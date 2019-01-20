/* Quartus II 64-Bit Version 14.1.0 Build 186 12/03/2014 SJ Web Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEMA5F31) Path("C:/Users/stfar/cpen311/lab1/solution/") File("Lab1_DE1SoC_Solution.sof") MfrSpec(OpMask(1));
	P ActionCode(Ign)
		Device PartName(5CSEMA5) MfrSpec(OpMask(0));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
