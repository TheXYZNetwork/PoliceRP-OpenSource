handcuffs.Config.Punishments = {
	-- FELONIES
	-- Crimes involving loss of life
	{name = "Murder", time = 8, category = "Crimes Involving Loss of Life"},
	{name = "Attempted Murder", time = 7, category = "Crimes Involving Loss of Life"},
	{name = "Manslaughter", time = 5, category = "Crimes Involving Loss of Life"},
	-- Crimes Involving Weapons
	{name = "Possession of a Firearm", time = 3, category = "Crimes Involving Weapons"},
	{name = "Illegal Discharge of a Firearm", time = 3, category = "Crimes Involving Weapons"},
	{name = "Illegal Distribution of a Firearm", time = 5, category = "Crimes Involving Weapons"},
	-- Crimes of a Violent Nature
	{name = "Jailbreak", time = 10, category = "Crimes of a Violent Nature"},
	{name = "Bank Robbery", time = 10, category = "Crimes of a Violent Nature"},
	{name = "PD Raid", time = 10, category = "Crimes of a Violent Nature"},
	{name = "Robbery", time = 8, category = "Crimes of a Violent Nature"},
	{name = "Burglary", time = 9, category = "Crimes of a Violent Nature"},
	{name = "Grevious Bodily Harm", time = 6, category = "Crimes of a Violent Nature"},
	{name = "Kidnapping", time = 8, category = "Crimes of a Violent Nature"},
	{name = "Acts of terror", time = 10, cannotBail = true, category = "Crimes of a Violent Nature"},
	{name = "Threats of a Terrorist Nature", time = 5, category = "Crimes of a Violent Nature"},
	-- Drug Offences
	{name = "Cultivation of Drugs", time = 5, category = "Drug Offences"},
	{name = "Intent to Supply Drugs", time = 8, category = "Drug Offences"},
	{name = "Possession of Drugs", time = 5, category = "Drug Offences"},
	-- Vehicular Offences
	{name = "Grand Theft Auto", time = 4, category = "Vehicular Offences"},
	{name = "Carjacking", time = 5, category = "Vehicular Offences"},
	{name = "Hit and Run", time = 3, category = "Vehicular Offences"},
	{name = "Refusing to Stop for a Police Officer", time = 4, category = "Vehicular Offences"},
	{name = "Vehicular Assault", time = 3, category = "Vehicular Offences"},
	{name = "Reckless Driving Resulting in Serious Injury", time = 4, category = "Vehicular Offences"},
	{name = "Driving Under the Influence", time = 3, category = "Vehicular Offences"},
	{name = "Improper Operation of a Government Issued Vehicle", time = 3, category = "Vehicular Offences"},
	{name = "Operation of a vehicle with no license", time = 3, category = "Vehicular Offences"},
	-- Miscellaneous Felonies
	{name = "Production of Counterfeit Money", time = 4, category = "Miscellaneous Felonies"},
	{name = "Possession of Stolen Goods", time = 4, category = "Miscellaneous Felonies"},
	{name = "Money Laundering", time = 4, category = "Miscellaneous Felonies"},
	{name = "Escaping Custody", time = 3, category = "Miscellaneous Felonies"},
	{name = "Obstruction of Justice", time = 3, category = "Miscellaneous Felonies"},
	{name = "Resisting Arrest", time = 2, category = "Miscellaneous Felonies"},
	{name = "Obstruction of an Emergency Vehicle", time = 2, category = "Miscellaneous Felonies"},
	{name = "Solcitation", time = 2, category = "Miscellaneous Felonies"},
	{name = "Hacking", time = 4, category = "Miscellaneous Felonies"},
	{name = "Bribery", time = 4, category = "Miscellaneous Felonies"},
	-- MISDEMEANOR CRIMES
	{name = "False Report", time = 1, category = "Misdemeanor Crimes"},
	{name = "Plotting to Commit a Felony or Misdemeanor", time = 2, category = "Misdemeanor Crimes"},
	{name = "Trespassing", time = 1, category = "Misdemeanor Crimes"},
	{name = "Prostitution", time = 3, category = "Misdemeanor Crimes"},
	{name = "Obstructing Traffic", time = 1, category = "Misdemeanor Crimes"},
	{name = "Violating a Lawful Order", time = 1, category = "Misdemeanor Crimes"},
	{name = "Assault", time = 3, category = "Misdemeanor Crimes"},
	{name = "Destruction of Property", time = 4, category = "Misdemeanor Crimes"},
	{name = "Failing to Pay a Fine", time = 3, category = "Misdemeanor Crimes"}

}
-- This is now changed to be paid per year they're in for
handcuffs.Config.JailPay = 1000
-- The max they can be paid
handcuffs.Config.JailPayCap = 5000
handcuffs.Config.BailPrice = 25000