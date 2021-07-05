function junk = constructSigmoidPhenotypeFactorTest(alleleWeights, phenotypeFactor)

for ix1 = 0:2,
	for ix2 = 0:2,
		for ix3 = 0:2,
			for ix4 = 0:2,
				z = alleleWeights{1}(1) * ix1 + alleleWeights{1}(2) * ix2 + alleleWeights{2}(1) * ix3 + alleleWeights{2}(2) * ix4;
				printf('alleleWeights:[%d %d %d %d]: computeSigmoid = %0.5f\n', ix1, ix2, ix3, ix4, computeSigmoid(z));
			end
		end		
	end
end

%disp(phenotypeFactor.val);

for indx = 1:prod(phenotypeFactor.card),
	assgn = IndexToAssignment(indx, phenotypeFactor.card);
	if length(phenotypeFactor.var) == 5,
		printf('indx: %2d; assgn:[%d %d %d %d %d]; val:%0.5f\n', indx, assgn(1), assgn(2), assgn(3), assgn(4), assgn(5), phenotypeFactor.val(indx));
	else
		printf('length(phenotypeFactor.var): %d not supported\n', length(phenotypeFactor.var));
	end

	if assgn(1) == 1,
		z = [dot(alleleWeights{1}, assgn(2:3)) dot(alleleWeights{2}, assgn(4:5))];
	elseif assgn(1) == 2,
	else
		printf('phenotypes of card %d not supported\n', phenotypeFactor.card(1))
	end	
end