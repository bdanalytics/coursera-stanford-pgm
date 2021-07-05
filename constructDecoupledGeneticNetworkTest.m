function junk = constructDecoupledGeneticNetworkTest(factorList, sampleFactorList)

%factorListDecoupled = FactorListDecoupled;
for ix = 1:length(sampleFactorList),
	printf('Testing factorList(%d)\n', ix)
	(length(factorList(ix).var) == length(sampleFactorList(ix).var)) && all(factorList(ix).var == sampleFactorList(ix).var)
	(length(factorList(ix).card) == length(sampleFactorList(ix).card)) && all(factorList(ix).card == sampleFactorList(ix).card)
	(length(factorList(ix).val) == length(sampleFactorList(ix).val)) && all(factorList(ix).val == sampleFactorList(ix).val)
end