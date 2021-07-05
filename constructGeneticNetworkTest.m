function junk = constructGeneticNetworkTest(factorList, sampleFactorList)

for ix = 1:length(sampleFactorList),
	printf('Testing factorList(%d)\n', ix)
	all(factorList(ix).var == sampleFactorList(ix).var)
	all(factorList(ix).card == sampleFactorList(ix).card)
	all(factorList(ix).val == sampleFactorList(ix).val)
end