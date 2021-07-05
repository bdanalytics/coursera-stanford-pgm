function genotypeFactor = genotypeGivenParentsGenotypesFactor(numAlleles, genotypeVarChild, genotypeVarParentOne, genotypeVarParentTwo)
% This function computes a factor representing the CPD for the genotype of
% a child given the parents' genotypes.

% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES

% When writing this function, make sure to consider all possible genotypes 
% from both parents and all possible genotypes for the child.

% Input:
%   numAlleles: int that is the number of alleles
%   genotypeVarChild: Variable number corresponding to the variable for the
%   child's genotype (goes in the .var part of the factor)
%   genotypeVarParentOne: Variable number corresponding to the variable for
%   the first parent's genotype (goes in the .var part of the factor)
%   genotypeVarParentTwo: Variable number corresponding to the variable for
%   the second parent's genotype (goes in the .var part of the factor)
%
% Output:
%   genotypeFactor: Factor in which val is probability of the child having 
%   each genotype (note that this is the FULL CPD with no evidence 
%   observed)

% The number of genotypes is (number of alleles choose 2) + number of 
% alleles -- need to add number of alleles at the end to account for homozygotes

genotypeFactor = struct('var', [], 'card', [], 'val', []);

% Each allele has an ID.  Each genotype also has an ID.  We need allele and
% genotype IDs so that we know what genotype and alleles correspond to each
% probability in the .val part of the factor.  For example, the first entry
% in .val corresponds to the probability of having the genotype with
% genotype ID 1, which consists of having two copies of the allele with
% allele ID 1, given that both parents also have the genotype with genotype
% ID 1.  There is a mapping from a pair of allele IDs to genotype IDs and 
% from genotype IDs to a pair of allele IDs below; we compute this mapping 
% using generateAlleleGenotypeMappers(numAlleles). (A genotype consists of 
% 2 alleles.)

[allelesToGenotypes, genotypesToAlleles] = generateAlleleGenotypeMappers(numAlleles);

% One or both of these matrices might be useful.
%
%   1.  allelesToGenotypes: n x n matrix that maps pairs of allele IDs to 
%   genotype IDs, where n is the number of alleles -- if 
%   allelesToGenotypes(i, j) = k, then the genotype with ID k comprises of 
%   the alleles with IDs i and j
%
%   2.  genotypesToAlleles: m x 2 matrix of allele IDs, where m is the 
%   number of genotypes -- if genotypesToAlleles(k, :) = [i, j], then the 
%   genotype with ID k is comprised of the allele with ID i and the allele 
%   with ID j

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INSERT YOUR CODE HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% Fill in genotypeFactor.var.  This should be a 1-D row vector.
genotypeFactor.var = [genotypeVarChild, genotypeVarParentOne, genotypeVarParentTwo];

% Fill in genotypeFactor.card.  This should be a 1-D row vector.
numGenotypes = nchoosek(numAlleles, 2) + numAlleles;
genotypeFactor.card = [numGenotypes, numGenotypes, numGenotypes];

genotypeFactor.val = zeros(1, prod(genotypeFactor.card));
% Replace the zeros in genotypeFactor.val with the correct values.

%for indx = 1:prod(genotypeFactor.card),
%	assgn = IndexToAssignment(indx, genotypeFactor.card);
%	printf('indx: %3d; assgn:[%d %d %d]\n', indx, assgn(1), assgn(2), assgn(3));
%end;

for parentOneGenotype = 1:numGenotypes,
	for parentTwoGenotype = 1:numGenotypes,
		%alleleSet = unique([genotypesToAlleles(parentOneGenotype, :), genotypesToAlleles(parentTwoGenotype, :)]);
		%printf('parentOneGenotype: %d; parentTwoGenotype: %d; length(alleleSet): %d\n', parentOneGenotype, parentTwoGenotype, length(alleleSet));
		%if (length(alleleSet) == 1),
		%	printf('	alleleSet:[%d]\n', alleleSet(1));
		%elseif (length(alleleSet) == 2),
		%	printf('	alleleSet:[%d %d]\n', alleleSet(1), alleleSet(2));
		%else
		%	printf('	alleleSet: should not happen\n')	
		%endif		

		%if (length(setdiff(alleleSet, [1])) == 0), % alleleSet == [1]
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 1.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.0);
		%elseif (length(setdiff(alleleSet, [2])) == 0), % alleleSet == [2]
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 1.0);
		%elseif (all(genotypesToAlleles(parentOneGenotype, : == [1 1])) || 
		%	    all(genotypesToAlleles(parentTwoGenotype, : == [1 1]))) % alleleSet == [1, 2]
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.50);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.50);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.00);
		%else % alleleSet == [1, 2]
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.25);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.50);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.25);
		%endif	

		%if     (all(genotypesToAlleles(parentOneGenotype, :) == [1 1]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [1 1])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 1.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.0);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [1 1]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [1 2])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.5);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.5);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.0);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [1 1]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [2 2])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 1.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.0);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [1 2]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [1 1])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.5);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.5);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.0);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [1 2]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [1 2])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.25);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.5);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.25);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [1 2]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [2 2])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.5);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.5);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [2 2]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [1 1])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 1.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.0);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [2 2]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [1 2])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.5);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 0.5);
		%elseif (all(genotypesToAlleles(parentOneGenotype, :) == [2 2]) && 
		%        all(genotypesToAlleles(parentTwoGenotype, :) == [2 2])),
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], 0.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], 1.0);
		%else 	
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [1, parentOneGenotype, parentTwoGenotype], -1.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [2, parentOneGenotype, parentTwoGenotype], -1.0);
		%	genotypeFactor = SetValueOfAssignment(genotypeFactor, [3, parentOneGenotype, parentTwoGenotype], -1.0);
		%endif	

		% Gather counts of childGenotype based on the permutations of alleles from this parents genotypes
		childGenotypeCounts = zeros(1, genotypeFactor.card(1));

		parentOneAlleles = genotypesToAlleles(parentOneGenotype, :);
		parentTwoAlleles = genotypesToAlleles(parentTwoGenotype, :);

		for parentOneAlleleIx = 1:length(parentOneAlleles),
			for parentTwoAlleleIx = 1:length(parentTwoAlleles),
				childAlleles = [parentOneAlleles(parentOneAlleleIx), parentTwoAlleles(parentTwoAlleleIx)];
				childGenotype = allelesToGenotypes(childAlleles(1), childAlleles(2));
				childGenotypeCounts(childGenotype) += 1;
			end;	
		end;	

		childGenotypeProbs = childGenotypeCounts / sum(childGenotypeCounts);

%		printf('parentOneGenotype: %d; parentTwoGenotype: %d; childGenotypeCounts: ', parentOneGenotype, parentTwoGenotype);
%		childGenotypeCounts
%		printf('parentOneGenotype: %d; parentTwoGenotype: %d; childGenotypeProbs: ', parentOneGenotype, parentTwoGenotype);
%		childGenotypeProbs
%		printf('\n')

		for childGenotype = 1:numGenotypes,
			genotypeFactor = SetValueOfAssignment(genotypeFactor, [childGenotype, parentOneGenotype, parentTwoGenotype], childGenotypeProbs(childGenotype));
		end;	

	end;	
end;	


%for childIx = 1:numGenotypes,
%	for parentOneIx = 1:numGenotypes,
%		for parentTwoIx = 1:numGenotypes,
%			assgn = [childIx, parentOneIx, parentTwoIx]
%			indx = AssignmentToIndex(assgn, genotypeFactor.card);
%			printf('assgn: %s; indx: %d\n', assgn, indx)
%		end;	
%	end;	
%end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%