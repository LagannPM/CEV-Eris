/datum/language/xenocommon
	name = LANGUAGE_XENOMORPH
	colour = "alien"
	desc = "The common tongue of the xenomorphs."
	speech_verb = list("hisses")
	ask_verb = list("hisses")
	exclaim_verb = list("hisses")
	key = "4"
	flags = RESTRICTED
	syllables = list("sss","sSs","SSS")
	shorthand = "Xeno"

/datum/language/xenos
	name = LANGUAGE_HIVEMIND
	desc = "Xenomorphs have the strange ability to commune over a psychic hivemind."
	speech_verb = list("hisses")
	ask_verb = list("hisses")
	exclaim_verb = list("hisses")
	colour = "alien"
	key = "a"
	flags = RESTRICTED | HIVEMIND
	shorthand = "N/A"

/datum/language/xenos/check_special_condition(var/mob/other)

	var/mob/living/carbon/M = other
	if(!istype(M))
		return 1
	if(locate(/obj/item/organ/internal/xenos/hivenode) in M.internal_organs)
		return 1

	return 0

/datum/language/ling
	name = LANGUAGE_CHANGELING
	desc = "Although they are normally wary and suspicious of each other, changelings can commune over a distance."
	colour = "changeling"
	key = "g"
	flags = RESTRICTED | HIVEMIND
	shorthand = "N/A"

/datum/language/ling/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)

	if(speaker.mind && speaker.mind.changeling)
		..(speaker,message,speaker.mind.changeling.changelingID)
	else
		..(speaker,message)

/datum/language/corticalborer
	name = LANGUAGE_CORTICAL
	desc = "Cortical borers possess a strange link between their tiny minds."
	speech_verb = list("sings")
	ask_verb = list("sings")
	exclaim_verb = list("sings")
	colour = "alien"
	key = "x"
	flags = RESTRICTED | HIVEMIND
	shorthand = "N/A"

/datum/language/corticalborer/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)

	var/mob/living/simple_animal/borer/B

	if(iscarbon(speaker))
		var/mob/living/carbon/M = speaker
		B = M.has_brain_worms()
	else if(istype(speaker,/mob/living/simple_animal/borer))
		B = speaker

	if(B)
		speaker_mask = B.truename
	..(speaker,message,speaker_mask)

/datum/language/cultcommon
	name = LANGUAGE_CULT
	desc = "The chants of the occult, the incomprehensible."
	speech_verb = list("intones")
	ask_verb = list("intones")
	exclaim_verb = list("chants")
	colour = "cult"
	key = "f"
	flags = RESTRICTED
	space_chance = 100
	syllables = list("ire","ego","nahlizet","certum","veri","jatkaa","mgar","balaq", "karazet", "geeri", \
		"orkan", "allaq", "sas'so", "c'arta", "forbici", "tarem", "n'ath", "reth", "sh'yro", "eth", "d'raggathnor", \
		"mah'weyh", "pleggh", "at", "e'ntrath", "tok-lyr", "rqa'nap", "g'lt-ulotf", "ta'gh", "fara'qha", "fel", "d'amar det", \
		"yu'gular", "faras", "desdae", "havas", "mithum", "javara", "umathar", "uf'kal", "thenar", "rash'tla", \
		"sektath", "mal'zua", "zasan", "therium", "viortia", "kla'atu", "barada", "nikt'o", "fwe'sh", "mah", "erl", "nyag", "r'ya", \
		"gal'h'rfikk", "harfrandid", "mud'gib", "fuu", "ma'jin", "dedo", "ol'btoh", "n'ath", "reth", "sh'yro", "eth", \
		"d'rekkathnor", "khari'd", "gual'te", "nikka", "nikt'o", "barada", "kla'atu", "barhah", "hra" ,"zar'garis")
	shorthand = "CT"

/datum/language/serbian
	name = LANGUAGE_SERBIAN
	desc = "Language popular among Serbian mercenaries, pirates and habitants of Predstraza planet."
	colour = "serbian"
	key = "x"
	flags = RESTRICTED
	space_chance = 80
	shorthand = "SB"
	syllables = list("zena", "rob", "macka", "tvoj", "ruke", "jebote", "placenik", "tsatsh", "da", "zivim", "cich", "jovan", "be", "ot", \
					 "ja", "tamo", "moj", "za", "gdje", "su", "brodove", "noge", "da", "ne", "svemirskog", "pochemu", "zasto","ljubav", \
					 "zajebavati", "krevet", "tabela", "za", "red", "dan", "voyna", "rat", "razmisljam", "bubasvaba", "zdravlje", "dan", "novac", \
					 "jebeno", "mate", "tvoj", "kucka", "ayblya", "ja", "sisati", "kurac", "uciniti", "pobediti", "picka", "krades", "probajte", "zapaljen", \
					 "razgovaramo", "sranje", "naci", "ubijen", "nakazo", "dodavola", "zakacis", "prosrali", "suche", "elektricar", "glupo", "dole", "lepo", \
					 "bolestan", "savrsenstvo", "vristi", "beda", "muesli", "spasenje", "pomoc", "zvezdej", "prostor", "osvaja", "zavrsim", "jezero",  \
					 "mesec", "nagib", "planeta", "pozovi", "treperenje", "smeh", "svesnost", "raditi", "mucenje", "cudo", "magarci", "sudbina", "sloboda", \
					 "provodljivost", "inicijalizacija", "kompjuter", "mlada", "glumac", "analiza", "andeo", \
					 "vojska", "napad", "atmosferu", "laser", "tocno", "uprave", "zapamti", "automatskog", "uredaja", \
					 "pecnice", "platiti", "pozari", "pokazati", "zivot", "radio", "bojne", "uzasno", "ujutro", "sudionika", \
					 "gas", "glavnog", "grijeh", "granica", "zeljezo", "baterije", "knjiznica", "kontrola", "borba", \
					 "brat", "zidov", "jedu", "jeo", "prirodno", "alat", "zainteresiran", "koristenje", "tako", "njihov", \
					 "dinamica", "brzo", "organizacuya", "yeyenet", "radio", "peredacha", "priem", "slushno", "chastota", "gerts", "stantiya", \
					 "biti", "je", "ponekad", "jedan", "cetiri", "pet", "granata", "br", "re", "da", "do")

/datum/language/cult
	name = LANGUAGE_OCCULT
	desc = "The initiated can share their thoughts by means defying all reason."
	speech_verb = list("intones")
	ask_verb = list("intones")
	exclaim_verb = list("chants")
	colour = "cult"
	key = "y"
	flags = RESTRICTED | HIVEMIND
	shorthand = "N/A"
