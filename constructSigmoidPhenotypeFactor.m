function phenotypeFactor = constructSigmoidPhenotypeFactor(alleleWeights, geneCopyVarOneList, geneCopyVarTwoList, phenotypeVar)
% This function takes a cell array of alleles' weights and constructs a 
% factor expressing a sigmoid CPD.
%
% You can assume that there are only 2 genes involved in the CPD.
%
% In the factor, for each gene, each allele assignment maps to the allele
% whose weight is at the corresponding location.  For example, for gene 1,
% allele assignment 1 maps to the allele whose weight is at
% alleleWeights{1}(1) (same as w_1^1), allele assignment 2 maps to the
% allele whose weight is at alleleWeights{1}(2) (same as w_2^1),....  
% 
% You may assume that there are 2 possible phenotypes.
% For the phenotypes, assignment 1 maps to having the physical trait, and
% assignment 2 maps to not having the physical trait.
%
% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES
%
% Input:
%   alleleWeights: Cell array of weights, where each entry is an 1 x n 
%   of weights for the alleles for a gene (n is the number of alleles for
%   the gene)
%   geneCopyVarOneList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the first parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor)
%   geneCopyVarTwoList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the second parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor) -- Note that both copies of each gene are from the same person,
%   but each copy originally came from a different parent
%   phenotypeVar: Variable number corresponding to the variable for the 
%   phenotype (goes in the .var part of the factor)
%
% Output:
%   phenotypeFactor: Factor in which the values are the probabilities of 
%   having each phenotype for each allele combination (note that this is 
%   the FULL CPD with no evidence observed)

phenotypeFactor = struct('var', [], 'card', [], 'val', []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INSERT YOUR CODE HERE
% Note that computeSigmoid.m will be useful for this function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% Fill in phenotypeFactor.var.  This should be a 1-D row vector.
%phenotypeFactor.var = [phenotypeVar geneCopyVarOneList geneCopyVarTwoList];
phenotypeFactor.var = [phenotypeVar geneCopyVarOneList(1) geneCopyVarOneList(2) geneCopyVarTwoList(1) geneCopyVarTwoList(2)];

% Fill in phenotypeFactor.card.  This should be a 1-D row vector.
phenotypeFactor.card = [2 2 2 2 2]; 

phenotypeFactor.val = zeros(1, prod(phenotypeFactor.card));
% Replace the zeros in phentoypeFactor.val with the correct values.

for indx = 1:prod(phenotypeFactor.card),
	assgn = IndexToAssignment(indx, phenotypeFactor.card);
	if length(phenotypeFactor.var) == 5,
		numABig = 0; numASmall = 0; numBBig = 0; numBSmall = 0;
		if assgn(2) == 1 numABig += 1;else numASmall += 1; end
		if assgn(4) == 1 numABig += 1;else numASmall += 1; end
		if assgn(3) == 1 numBBig += 1;else numBSmall += 1; end
		if assgn(5) == 1 numBBig += 1;else numBSmall += 1; end
	else
		printf('length(phenotypeFactor.var): %d not supported\n', length(phenotypeFactor.var));
	end

	if assgn(1) == 1,
		%z = [dot(alleleWeights{1}, assgn(2:3)) dot(alleleWeights{2}, assgn(4:5))];
		z = alleleWeights{1}(1) * numABig + alleleWeights{1}(2) * numASmall + alleleWeights{2}(1) * numBBig + alleleWeights{2}(2) * numBSmall;
		phenotypeFactor.val(indx) = computeSigmoid(z);
	elseif assgn(1) == 2,
		phenotypeFactor.val(indx) = 1.0 - phenotypeFactor.val(indx - 1);
	else
		printf('phenotypes of card %d not supported\n', phenotypeFactor.card(1))
	end	
	%printf('indx: %2d; assgn:[%d %d %d %d %d] -> alleles: [%d %d %d %d] -> prob: %0.5f\n', indx, assgn(1), assgn(2), assgn(3), assgn(4), assgn(5), numABig, numASmall, numBBig, numBSmall, phenotypeFactor.val(indx));
end

%disp(phenotypeFactor)	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%