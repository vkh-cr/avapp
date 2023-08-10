import 'package:av_app/models/UserInfoModel.dart';
import 'package:av_app/services/DataService.dart';
import 'package:av_app/services/ToastHelper.dart';

class MailerSendHelper{
  static void sendPassword(UserInfoModel recipient, String password) async {
    var passwordVar = {"var":"password", "value":password};
    var emailVar = {"var":"email", "value":recipient.email};
    var variables = [passwordVar, emailVar];
    variables.addAll(_getSalutationPresalutation(recipient));
    await DataService.emailMailerSend(recipient.email, "jy7zpl9nqe545vx6", variables);
    ToastHelper.Show("Email byl odeslán uživateli: ${recipient.email}");
  }

  static List<Map<String, String>> _getSalutationPresalutation(UserInfoModel user)
  {
    var presalutation = {"var":"presalutation", "value":user.sex == "male" ? "Milý": "Milá"};
    var salutation = {"var":"salutation", "value":_getVocation(user.name)};
    return [presalutation, salutation];
  }

  static String _getVocation(String name){
    if(_vocatives.containsKey(name))
    {
      return _vocatives[name]!;
    }
    return name;
  }

  static final Map<String, String> _vocatives = {
    "Adam":"Adame",
    "Adolf":"Ádo",
    "Adrian":"Adriane",
    "Adrián":"Adriáne",
    "Ahmed":"Ahmede",
    "Aladár":"Aladáre",
    "Alan":"Alane",
    "Albert":"Alberte",
    "Albín":"Albíne",
    "Aleksandar":"Aleksandare",
    "Aleksandr":"Aleksandře",
    "Alessandro":"Alessandro",
    "Aleš":"Aleši",
    "Alex":"Alexi",
    "Alexander":"Sašo",
    "Alexandr":"Sašo",
    "Alexandru":"Alexandru",
    "Alexei":"Alexei",
    "Alexej":"Alexeji",
    "Alexey":"Alexeyi",
    "Alfons":"Alfonsi",
    "Alfred":"Alfrede",
    "Alfréd":"Alfréde",
    "Ali":"Ali",
    "Aliaksandr":"Aliaksandre",
    "Alois":"Lojzo",
    "Alojz":"Lojzo",
    "Anatol":"Anatole",
    "Anatolie":"Anatolie",
    "Anatolii":"Anatolii",
    "Anatolij":"Anatoliji",
    "Anatoliy":"Anatoliyi",
    "Anatoly":"Anatoly",
    "André":"André",
    "Andreas":"Andreasi",
    "Andrei":"Andrei",
    "Andrej":"Andreji",
    "Andrey":"Andreyi",
    "Andrii":"Andrii",
    "Andriy":"Andriyi",
    "Andrzej":"Andrzeji",
    "Anh":"Anhu",
    "Anton":"Antone",
    "Antonín":"Tondo",
    "Antonio":"Antonio",
    "Arnold":"Arnolde",
    "Arnošt":"Arnošte",
    "Arpád":"Arpáde",
    "Artem":"Arteme",
    "Artur":"Arture",
    "Attila":"Attilo",
    "Augustin":"Gusto",
    "Augustín":"Augustíne",
    "Barnabáš":"Barnabáši",
    "Bartolomej":"Bartolomeji",
    "Bartoloměj":"Bartoloměji",
    "Bedřich":"Béďo",
    "Benedikt":"Benedikte",
    "Benjamin":"Benjamine",
    "Benjamín":"Benjamíne",
    "Bernard":"Bernarde",
    "Binh":"Binhu",
    "Blahoslav":"Blahoslave",
    "Blařej":"Blařeji",
    "Bogdan":"Bogdane",
    "Bohdan":"Bohdane",
    "Bohumil":"Bohouši",
    "Bohumír":"Bohumíre",
    "Bohuslav":"Bohouši",
    "Bohuš":"Bohuši",
    "Boleslav":"Bolku",
    "Borek":"Borku",
    "Boris":"Borisi",
    "Borys":"Borysi",
    "Bořek":"Bořku",
    "Bořetěch":"Bořetěchu",
    "Bořivoj":"Bořku",
    "Branislav":"Branislave",
    "Brian":"Briane",
    "Bronislav":"Broňku",
    "Bruno":"Bruno",
    "Břetislav":"Břéťo",
    "Constantin":"Constantine",
    "Ctibor":"Ctibore",
    "Ctirad":"Ctirade",
    "Cuong":"Cuongu",
    "Cyril":"Cyrile",
    "Čeněk":"Čeňku",
    "Česlav":"Česlave",
    "Čestmír":"Čestmíre",
    "Dalibor":"Dalibore",
    "Dalimil":"Dalimile",
    "Damian":"Damiane",
    "Damián":"Damiáne",
    "Damir":"Damire",
    "Dan":"Dane",
    "Daniel":"Dane",
    "Danny":"Danny",
    "Darek":"Darku",
    "Dariusz":"Dariuszi",
    "Dat":"Date",
    "David":"Davide",
    "Dávid":"Dávide",
    "Dejan":"Dejane",
    "Denis":"Denisi",
    "Dennis":"Dennisi",
    "Denys":"Denysi",
    "Dezider":"Dezidere",
    "Dieter":"Dietere",
    "Dimitrij":"Dimitriji",
    "Dmitrij":"Dmitriji",
    "Dmitriy":"Dmitriyi",
    "Dmitry":"Dmitry",
    "Dmytro":"Dmytro",
    "Dobromil":"Dobromile",
    "Dobroslav":"Dobroslave",
    "Dominik":"Dominiku",
    "Dragan":"Dragane",
    "Drahomír":"Drahomíre",
    "Drahoslav":"Drahoslave",
    "Duc":"Duci",
    "Dumitru":"Dumitru",
    "Dung":"Dungu",
    "Duong":"Duongu",
    "Dušan":"Dušane",
    "Edgar":"Edgare",
    "Edmund":"Edmunde",
    "Eduard":"Edo",
    "Edvard":"Edvarde",
    "Edward":"Edwarde",
    "Egon":"Egone",
    "Elemír":"Elemíre",
    "Eliáš":"Eliáši",
    "Emanuel":"Emanueli",
    "Emerich":"Emerichu",
    "Emil":"Emile",
    "Enrico":"Enrico",
    "Erhard":"Erharde",
    "Eric":"Ericu",
    "Erich":"Erichu",
    "Erik":"Eriku",
    "Ernest":"Erneste",
    "Ervin":"Ervine",
    "Ervín":"Ervíne",
    "Eugen":"Eugene",
    "Evald":"Evalde",
    "Evgeny":"Evgeny",
    "Evžen":"Evžene",
    "Fabian":"Fabiane",
    "Fabián":"Fabiáne",
    "Fedir":"Fedire",
    "Fedor":"Fedore",
    "Felix":"Felixi",
    "Ferdinand":"Ferdo",
    "Filip":"Filipe",
    "Florian":"Floriane",
    "Florián":"Floriáne",
    "Francesco":"Francesco",
    "Frank":"Franku",
    "František":"Františku",
    "Franz":"Franzi",
    "Gabriel":"Gabrieli",
    "Günter":"Güntere",
    "Günther":"Günthere",
    "Gejza":"Gejzo",
    "Georg":"Georgu",
    "George":"George",
    "Georgi":"Georgi",
    "Georgios":"Georgiosi",
    "Gerhard":"Gerharde",
    "Gheorghe":"Gheorghe",
    "GĹ±nter":"GĹ±ntere",
    "Goran":"Gorane",
    "Grigore":"Grigore",
    "Grzegorz":"Grzegorzi",
    "Gustav":"Gusto",
    "Ha":"Hao",
    "Hai":"Hai",
    "Hans":"Hansi",
    "Hanuš":"Hanuši",
    "Harald":"Haralde",
    "Harry":"Harry",
    "Heinz":"Heinzi",
    "Helmut":"Helmute",
    "Henrich":"Henrichu",
    "Henryk":"Henryku",
    "Herbert":"Herberte",
    "Heřman":"Heřmane",
    "Hien":"Hiene",
    "Hieu":"Hieu",
    "Hoa":"Hoao",
    "Hoang":"Hoangu",
    "Horst":"Horste",
    "Horymír":"Horymíre",
    "Hryhoriy":"Hryhoriyi",
    "Hubert":"Huberte",
    "Hugo":"Hugo",
    "Hung":"Hungu",
    "Huy":"Huy",
    "Hynek":"Hynku",
    "Christian":"Christiane",
    "Christopher":"Christophere",
    "Iaroslav":"Iaroslave",
    "Ievgen":"Ievgene",
    "Ignác":"Ignáci",
    "Igor":"Igore",
    "Ihor":"Ihore",
    "Ilja":"Iljo",
    "Illya":"Illyo",
    "Ilya":"Ilyo",
    "Imrich":"Imrichu",
    "Ioan":"Ioane",
    "Ion":"Ione",
    "Iosif":"Iosife",
    "Iurie":"Iurie",
    "Iurii":"Iurii",
    "Ivan":"Ivane",
    "Ivo":"Ivo",
    "Ivoš":"Ivoši",
    "Jacek":"Jacku",
    "Jáchym":"Jáchyme",
    "Jakub":"Kubo",
    "Jürgen":"Jürgene",
    "JĂłzef":"JĂłzefe",
    "Jan":"Honzo",
    "Ján":"Jáne",
    "Janis":"Janisi",
    "Janusz":"Januszi",
    "Jarmil":"Jarmile",
    "Jarolím":"Jarolíme",
    "Jaromír":"Jardo",
    "Jaroslav":"Jardo",
    "Jeroným":"Jeronýme",
    "Jerzy":"Jerzy",
    "Jiljí":"Jiljí",
    "Jindřich":"Jindro",
    "Jiří":"Jirko",
    "Joachim":"Joachime",
    "Johann":"Johanne",
    "John":"Johne",
    "Jonáš":"Jonáši",
    "Josef":"Pepo",
    "Jozef":"Pepo",
    "Jůlius":"Julo",
    "Julius":"Julo",
    "Juraj":"Juraji",
    "Jurij":"Juriji",
    "Justin":"Justine",
    "Kamil":"Kamile",
    "Karel":"Kájo",
    "Karim":"Karime",
    "Karl":"Karle",
    "Karol":"Karole",
    "Kazimierz":"Kazimierzi",
    "Kazimír":"Kazimíre",
    "Kevin":"Kevine",
    "Khanh":"Khanhu",
    "Kirill":"Kirille",
    "Klaus":"Klausi",
    "Klement":"Klemente",
    "Koloman":"Kolomane",
    "Konrád":"Konráde",
    "Konstantin":"Konstantine",
    "Kostyantyn":"Kostyantyne",
    "Kristian":"Kristiane",
    "Kristián":"Kristiáne",
    "Kryštof":"Kryštofe",
    "Krzysztof":"Krzysztofe",
    "Kurt":"Kurte",
    "Květoslav":"Slávku",
    "Ladislav":"Láďo",
    "Lam":"Lame",
    "Leo":"Leo",
    "Leon":"Leone",
    "Leonard":"Leonarde",
    "Leonid":"Leonide",
    "Leopold":"Leopolde",
    "Leoš":"Leoši",
    "Leszek":"Leszku",
    "Lešek":"Lešku",
    "Lev":"Lve:Leve",
    "Libor":"Libore",
    "Long":"Longu",
    "Lubomír":"Lubomíre",
    "Ľubomír":"Ľubomíre",
    "Lubor":"Lubore",
    "Luboš":"Luboši",
    "Ľuboš":"Ľuboši",
    "Lucas":"Lucasi",
    "Luděk":"Luďku",
    "Ludevít":"Ludevíte",
    "Ludovít":"Ludovíte",
    "Ľudovit":"Ľudovite",
    "Ľudovít":"Ľudovíte",
    "Ludvík":"Ludvíku",
    "Lukas":"Lukasi",
    "Lukáš":"Lukáši",
    "Lumír":"Lumíre",
    "Lyubomyr":"Lyubomyre",
    "Maksym":"Maksyme",
    "Manfred":"Manfrede",
    "Manh":"Manhu",
    "Marcel":"Marceli",
    "Marcin":"Marcine",
    "Marco":"Marco",
    "Marek":"Marku",
    "Marian":"Mariane",
    "Marián":"Mariáne",
    "Mario":"Mario",
    "Mário":"Mário",
    "Mariusz":"Mariuszi",
    "Mark":"Marku",
    "Marko":"Marko",
    "Markus":"Markusi",
    "Maroš":"Maroši",
    "Martin":"Martine",
    "Matej":"Mateji",
    "Matěj":"Matěji",
    "Mathias":"Mathiasi",
    "Matouš":"Matouši",
    "Matteo":"Matteo",
    "Matthias":"Matthiasi",
    "Matůš":"Matůši",
    "Matyas":"Matyasi",
    "Matyáš":"Matyáši",
    "Max":"Maxi",
    "Maxim":"Maxime",
    "Maximilian":"Maximiliane",
    "Maxmilian":"Maxmiliane",
    "Maxmilián":"Maxmiliáne",
    "Metoděj":"Metoději",
    "Mihail":"Mihaile",
    "Michael":"Michaeli",
    "Michail":"Michaile",
    "Michal":"Míšo",
    "Mikhail":"Mikhaile",
    "Mikoláš":"Mikoláši",
    "Mikuláš":"Mikuláši",
    "Milan":"Milane",
    "Milán":"Miláne",
    "Miloň":"Miloni",
    "Miloslav":"Mílo",
    "Miloš":"Miloši",
    "Milouš":"Milouši",
    "Minh":"Minhu",
    "Mirek":"Mirku",
    "Mirko":"Mirko",
    "Miroslav":"Mirku",
    "Miroslaw":"Miroslawe",
    "Mohamed":"Mohamede",
    "Mojmír":"Mojmíre",
    "Mykhailo":"Mykhailo",
    "Mykhaylo":"Mykhaylo",
    "Mykola":"Mykolo",
    "Myron":"Myrone",
    "Myroslav":"Myroslave",
    "Nam":"Name",
    "Nazar":"Nazare",
    "Nick":"Nicku",
    "Nicolae":"Nicolae",
    "Nicolas":"Nicolasi",
    "Nicholas":"Nicholasi",
    "Nikita":"Nikito",
    "Nikola":"Nikolo",
    "Nikolaj":"Nikolaji",
    "Nikolas":"Nikolasi",
    "Nikolay":"Nikolayi",
    "Nikos":"Nikosi",
    "Norbert":"Norberte",
    "Oldřich":"Oldo",
    "Oleg":"Olegu",
    "Oleh":"Olehu",
    "Oleksandr":"Oleksandře",
    "Oleksii":"Oleksii",
    "Oleksiy":"Oleksiyi",
    "Olexandr":"Olexandre",
    "Oliver":"Olivere",
    "Omar":"Omare",
    "Ondrej":"Ondreji",
    "Ondřej":"Ondro",
    "Orest":"Oreste",
    "Oskar":"Oskare",
    "Osvald":"Osvalde",
    "Ota":"Oto",
    "Otakar":"Otakare",
    "Otmar":"Otmare",
    "Oto":"Oto",
    "Otokar":"Otokare",
    "Otomar":"Otomare",
    "Otta":"Otto",
    "Otto":"Otto",
    "Patrick":"Patricku",
    "Patrik":"Patriku",
    "Paul":"Paule",
    "Pavel":"Pavle",
    "Pavlo":"Pavlo",
    "Pavol":"Pavole",
    "Petar":"Petare",
    "Peter":"Petere",
    "Petr":"Petře",
    "Petra":"Petro",
    "Petro":"Petro",
    "Petru":"Petru",
    "Philip":"Philipe",
    "Philipp":"Philippe",
    "Phong":"Phongu",
    "Phuong":"Phuongu",
    "Piotr":"Piotre",
    "Pravoslav":"Pravoslave",
    "Prokop":"Prokope",
    "Přemek":"Přemku",
    "Přemysl":"Přemku",
    "Quan":"Quane",
    "Quang":"Quangu",
    "Radan":"Radane",
    "Radek":"Radku",
    "Radim":"Radime",
    "Radimír":"Radimíre",
    "Radislav":"Radislave",
    "Radko":"Radko",
    "Radmil":"Radmile",
    "Radomil":"Radomile",
    "Radomír":"Radomíre",
    "Radoslav":"Radoslave",
    "Radovan":"Radovane",
    "Rafael":"Rafaeli",
    "Raimund":"Raimunde",
    "Rainer":"Rainere",
    "Rajmund":"Rajmunde",
    "RĂłbert":"RĂłberte",
    "Rastislav":"Rastislave",
    "Reinhard":"Reinharde",
    "Reinhold":"Reinholde",
    "René":"René",
    "Richard":"Richarde",
    "Robert":"Roberte",
    "Roberto":"Roberto",
    "Robin":"Robine",
    "Roland":"Rolande",
    "Roman":"Romane",
    "Ronald":"Ronalde",
    "Rostislav":"Rosťo",
    "Rostyslav":"Rostyslave",
    "Rudolf":"Rudo",
    "Ruslan":"Ruslane",
    "Ryszard":"Ryszarde",
    "Samir":"Samire",
    "Samuel":"Samueli",
    "Saša":"Sašo",
    "Sebastian":"Sebastiane",
    "Sebastián":"Sebastiáne",
    "Sebastien":"Sebastiene",
    "Semen":"Semene",
    "Sergej":"Sergeji",
    "Sergey":"Sergeyi",
    "Serghei":"Serghei",
    "Sergii":"Sergii",
    "Sergiu":"Sergiu",
    "Sergiy":"Sergiyi",
    "Serhiy":"Serhiyi",
    "Siarhei":"Siarhei",
    "Siegfried":"Siegfriede",
    "Silvester":"Silvestere",
    "Silvestr":"Silvestře",
    "Simon":"Simone",
    "Slávek":"Slávku",
    "Slavko":"Slavko",
    "Slavoj":"Slavoji",
    "Slavomil":"Slavomile",
    "Slavomír":"Slávku",
    "Son":"Sone",
    "Stanislav":"Stando",
    "Stanislaw":"Stanislawe",
    "Stefan":"Stefane",
    "Stepan":"Stepane",
    "Svatomír":"Svatomíre",
    "Svatopluk":"Sváťo",
    "Svatoslav":"Svatoslave",
    "Šimon":"Šimone",
    "Štefan":"Štefane",
    "Štěpán":"Štěpáne",
    "Tadeáš":"Tadeáši",
    "Tadeusz":"Tadeuszi",
    "Taras":"Tarasi",
    "Teodor":"Teodore",
    "Thang":"Thangu",
    "Thanh":"Thanhu",
    "Theodor":"Theodore",
    "Thomas":"Thomasi",
    "Tibor":"Tibore",
    "Tien":"Tiene",
    "Tiep":"Tiepe",
    "Timur":"Timure",
    "Toan":"Toane",
    "Tobias":"Tobiasi",
    "Tobiáš":"Tobiáši",
    "Tom":"Tome",
    "Tomasz":"Tomaszi",
    "Tomáš":"Tome",
    "Tomislav":"Tomislave",
    "Trung":"Trungu",
    "Truong":"Truongu",
    "Tu":"Tu",
    "Tuan":"Tuane",
    "Tung":"Tungu",
    "Václav":"Vašku",
    "Vadim":"Vadime",
    "Vadym":"Vadyme",
    "Valdemar":"Valdemare",
    "Valentin":"Valentine",
    "Valentyn":"Valentyne",
    "Valerii":"Valerii",
    "Valerij":"Valeriji",
    "Valeriu":"Valeriu",
    "Valeriy":"Valeriyi",
    "Valery":"Valery",
    "Valter":"Valtere",
    "Vasil":"Vasile",
    "Vasile":"Vasile",
    "Vasyl":"Vasyle",
    "Vavřinec":"Vávro",
    "Veaceslav":"Veaceslave",
    "Vendelín":"Vendelíne",
    "Verner":"Vernere",
    "Věroslav":"Věroslave",
    "Viacheslav":"Viacheslave",
    "Victor":"Victore",
    "Viet":"Viete",
    "Viktor":"Viktore",
    "Vilém":"Vildo",
    "Viliam":"Viliame",
    "Vilibald":"Vilibalde",
    "Vincenc":"Vincenci",
    "Vincent":"Vincente",
    "Vinh":"Vinhu",
    "Vít":"Vítku",
    "Vitalie":"Vitalie",
    "Vitalii":"Vitalii",
    "Vitalij":"Vitaliji",
    "Vitaliy":"Vitaliyi",
    "Vítek":"Vítku",
    "Vítězslav":"Víťo",
    "Vladan":"Vladane",
    "Vladimir":"Vladimire",
    "Vladimír":"Vladimíre",
    "Vladislav":"Vláďo",
    "Vladyslav":"Vladyslave",
    "Vlastimil":"Vlasto",
    "Vlastimír":"Vlastimíre",
    "Vlastislav":"Vláďo",
    "Vojta":"Vojto",
    "Vojtech":"Vojtechu",
    "Vojtěch":"Vojto",
    "Volodymyr":"Volodymyre",
    "Vratislav":"Vráťo",
    "Vyacheslav":"Vyacheslave",
    "Waldemar":"Waldemare",
    "Walter":"Waltere",
    "Werner":"Wernere",
    "William":"Williame",
    "Wolfgang":"Wolfgangu",
    "Yaroslav":"Yaroslave",
    "Yevgen":"Yevgene",
    "Yevhen":"Yevhene",
    "Yevheniy":"Yevheniyi",
    "Yosyp":"Yosype",
    "Yuriy":"Yuriyi",
    "Yury":"Yury",
    "Zbigniew":"Zbigniewe",
    "Zbyhněv":"Zbyhněve",
    "Zbyněk":"Zbyňku",
    "Zbyšek":"Zbyšku",
    "Zdenek":"Zdenku",
    "Zdeněk":"Zdeňku",
    "Zděnek":"Zděnku",
    "Zdenko":"Zdenko",
    "Zdislav":"Zdislave",
    "Zlatko":"Zlatko",
    "Zoltán":"Zoltáne",
    "Zoran":"Zorane",
    "Ada":"Ado",
    "Adela":"Adelo",
    "Adéla":"Adélo",
    "Adina":"Adino",
    "Adriana":"Adriano",
    "Adriána":"Adriáno",
    "Adriena":"Adrieno",
    "Agata":"Agato",
    "Agáta":"Agáto",
    "Agnesa":"Agneso",
    "Agneša":"Agnešo",
    "Agnieszka":"Agnieszko",
    "Albina":"Albino",
    "Albína":"Albíno",
    "Aleksandra":"Aleksandro",
    "Alena":"Alčo",
    "Alenka":"Alenko",
    "Alexandra":"Sašo",
    "Alica":"Alico",
    "Alice":"Alice",
    "Alicja":"Alicjo",
    "Alina":"Alino",
    "Alisa":"Aliso",
    "Alla":"Allo",
    "Alma":"Almo",
    "Aloisie":"Aloisie",
    "Alžbeta":"Alžbeto",
    "Alžběta":"Bětko",
    "Amália":"Amálio",
    "Amalie":"Amalie",
    "Amálie":"Amálko",
    "Amelie":"Amelie",
    "Amélie":"Amélie",
    "Ana":"Ano",
    "Anastasia":"Anastasio",
    "Anastasie":"Anastasie",
    "Anastasiya":"Anastasiyo",
    "Anastázia":"Anastázio",
    "Anastazie":"Anastazie",
    "Anastázie":"Anastázie",
    "Anděla":"Andělo",
    "Andrea":"Andreo",
    "Aneta":"Aneto",
    "Anetta":"Anetto",
    "Anežka":"Anežko",
    "Angela":"Angelo",
    "Angelika":"Angeliko",
    "Angelina":"Angelino",
    "Anh":"Anh",
    "Anika":"Aniko",
    "Anita":"Anito",
    "Anna":"Aničko",
    "Annelies":"Annelies",
    "Annemarie":"Annemarie",
    "AntĂłnia":"AntĂłnio",
    "Antonia":"Antonio",
    "Antonie":"Antonie",
    "Antonina":"Antonino",
    "Antonína":"Antoníno",
    "Anzhela":"Anzhelo",
    "Apolena":"Apoleno",
    "Aranka":"Aranko",
    "Arnošta":"Arnošto",
    "Arnoštka":"Arnoštko",
    "Augusta":"Augusto",
    "Augustina":"Augustino",
    "Aurelia":"Aurelio",
    "Aurelie":"Aurelie",
    "Bára":"Báro",
    "Barbara":"Barbaro",
    "Barbora":"Báro",
    "Beata":"Beato",
    "Beáta":"Beáto",
    "Beatrice":"Beatrice",
    "Bedřiška":"Bedřiško",
    "Běla":"Bělo",
    "Berenika":"Bereniko",
    "Bernardina":"Bernardino",
    "Berta":"Berto",
    "Bianka":"Bianko",
    "Bibiana":"Bibiano",
    "Blahoslava":"Blahoslavo",
    "Blanka":"Blanko",
    "Blažena":"Blaženo",
    "Bohdana":"Bohdano",
    "Bohdanka":"Bohdanko",
    "Bohumila":"Bohumilo",
    "Bohumíra":"Bohumíro",
    "Bohunka":"Bohunko",
    "Bohuslava":"Bohuslavo",
    "Božena":"Boženo",
    "Brigita":"Brigito",
    "Brigitta":"Brigitto",
    "Bronislava":"Broňo",
    "Carmen":"Carmen",
    "Carolina":"Carolino",
    "Caroline":"Caroline",
    "Cecília":"Cecílio",
    "Cecilie":"Cecilie",
    "Claudia":"Claudio",
    "Claudie":"Claudie",
    "Cristina":"Cristino",
    "Dagmar":"Dášo",
    "Dagmara":"Dagmaro",
    "Dana":"Dano",
    "Danica":"Danico",
    "Daniela":"Danielo",
    "Danka":"Danko",
    "Danuše":"Danuše",
    "Danuška":"Danuško",
    "Danuta":"Danuto",
    "Daria":"Dario",
    "Darina":"Darino",
    "Darja":"Darjo",
    "Daša":"Dašo",
    "Dáša":"Dášo",
    "Debora":"Deboro",
    "Denisa":"Deniso",
    "Diana":"Diano",
    "Dina":"Dino",
    "Dita":"Dito",
    "Dobromila":"Dobromilo",
    "Dobroslava":"Dobroslavo",
    "Dominika":"Dominiko",
    "Dora":"Doro",
    "Doris":"Doris",
    "Dorota":"Doroto",
    "Doubravka":"Doubravko",
    "Drahomila":"Drahomilo",
    "Drahomíra":"Drahomíro",
    "Drahoslava":"Drahoslavo",
    "Drahuše":"Drahuše",
    "Drahuška":"Drahuško",
    "Dung":"Dung",
    "Dušana":"Dušano",
    "Ecaterina":"Ecaterino",
    "Edeltraud":"Edeltraud",
    "Edeltrauda":"Edeltraudo",
    "Edeltruda":"Edeltrudo",
    "Edita":"Edito",
    "Edith":"Edith",
    "Ekaterina":"Ekaterino",
    "Ela":"Elo",
    "Elen":"Elen",
    "Elena":"Eleno",
    "Eleni":"Eleni",
    "EleonĂłra":"EleonĂłro",
    "Eleonora":"Eleonoro",
    "Elfrida":"Elfrido",
    "Elfrída":"Elfrído",
    "Elfrieda":"Elfriedo",
    "Elisabeth":"Elisabeth",
    "Eliška":"Eliško",
    "Elizabeth":"Elizabeth",
    "Elizaveta":"Elizaveto",
    "Ella":"Ello",
    "Ellen":"Ellen",
    "Elsa":"Elso",
    "Elvira":"Elviro",
    "Elvíra":"Elvíro",
    "Elzbieta":"Elzbieto",
    "Ema":"Emo",
    "Emanuela":"Emanuelo",
    "Emilia":"Emilio",
    "Emília":"Emílio",
    "Emilie":"Emilie",
    "Emílie":"Emílie",
    "Emily":"Emily",
    "Emma":"Emmo",
    "Erika":"Eriko",
    "Erna":"Erno",
    "Ester":"Ester",
    "Estera":"Estero",
    "Etela":"Etelo",
    "Eugenie":"Eugenie",
    "Eva":"Evo",
    "Evelina":"Evelino",
    "Evelína":"Evelíno",
    "Evžena":"Evženo",
    "Evženie":"Evženie",
    "Ewa":"Ewo",
    "Filomena":"Filomeno",
    "Františka":"Františko",
    "Gabriela":"Gábi",
    "Galina":"Galino",
    "Galyna":"Galyno",
    "Ganna":"Ganno",
    "Gerda":"Gerdo",
    "Gerlinda":"Gerlindo",
    "Gerlinde":"Gerlinde",
    "Gerta":"Gerto",
    "Gertruda":"Gertrudo",
    "Gisela":"Giselo",
    "Gita":"Gito",
    "Gizela":"Gizelo",
    "Grazyna":"Grazyno",
    "Gražyna":"Gražyno",
    "Greta":"Greto",
    "Ha":"Hao",
    "Halina":"Halino",
    "Halka":"Halko",
    "Halyna":"Halyno",
    "Hana":"Hanko",
    "Hang":"Hang",
    "Hanh":"Hanh",
    "HaniÄŤka":"HaniÄŤko",
    "Hanka":"Hanko",
    "Hanna":"Hanno",
    "Hannelore":"Hannelore",
    "Heda":"Hedo",
    "Hedviga":"Hedvigo",
    "Hedvika":"Hedviko",
    "Helena":"Helčo",
    "Helga":"Helgo",
    "Henrieta":"Henrieto",
    "Hermina":"Hermino",
    "Hermína":"Hermíno",
    "Herta":"Herto",
    "Hien":"Hien",
    "Hilda":"Hildo",
    "Hildegard":"Hildegard",
    "Hildegarda":"Hildegardo",
    "Hoa":"Hoa",
    "Hong":"Hong",
    "Hue":"Hue",
    "Huong":"Huong",
    "Huyen":"Huyen",
    "Charlota":"Charloto",
    "Charlotta":"Charlotto",
    "Charlotte":"Charlotte",
    "Chiara":"Chiaro",
    "Christa":"Christo",
    "Christina":"Christino",
    "Christine":"Christine",
    "Ida":"Ido",
    "Ilona":"Ilono",
    "Ilonka":"Ilonko",
    "Ilsa":"Ilso",
    "Ilse":"Ilse",
    "Ina":"Ino",
    "Inga":"Ingo",
    "Inge":"Inge",
    "Ingeborg":"Ingeborg",
    "Ingrid":"Ingrid",
    "Inka":"Inko",
    "Inna":"Inno",
    "Irena":"Ireno",
    "Irina":"Irino",
    "Irma":"Irmo",
    "Irmgard":"Irmgard",
    "Iryna":"Iryno",
    "Isabela":"Isabelo",
    "Isabella":"Isabello",
    "Iuliia":"Iuliio",
    "Iva":"Ivo",
    "Ivana":"Ivko",
    "Ivanka":"Ivanko",
    "Ivanna":"Ivanno",
    "Iveta":"Ivčo",
    "Ivona":"Ivono",
    "Izabela":"Izabelo",
    "Jadwiga":"Jadwigo",
    "Jana":"Jančo",
    "Janča":"Jančo",
    "Janetta":"Janetto",
    "Janette":"Janette",
    "Janina":"Janino",
    "Janka":"Janko",
    "Jarmila":"Jarko",
    "Jaromíra":"Jaromíro",
    "Jaroslava":"Jarko",
    "Jaruše":"Jaruše",
    "Jaruška":"Jaruško",
    "Jasmína":"Jasmíno",
    "Jelena":"Jeleno",
    "Jena":"Jeno",
    "Jenifer":"Jenifer",
    "Jennifer":"Jennifer",
    "Jenovefa":"Jenovefo",
    "Jenovéfa":"Jenovéfo",
    "Jesika":"Jesiko",
    "Jessica":"Jessico",
    "Jindra":"Jindro",
    "Jindřiška":"Jindro",
    "Jiřina":"Jiřko",
    "Jiřinka":"Jiřinko",
    "Jitka":"Jitko",
    "Jitřenka":"Jitřenko",
    "Joanna":"Joanno",
    "Johana":"Johano",
    "Johanka":"Johanko",
    "Johanna":"Johanno",
    "Jolana":"Jolano",
    "Jolanta":"Jolanto",
    "Josefa":"Josefo",
    "Josefina":"Josefino",
    "Josefína":"Josefíno",
    "Josefka":"Josefko",
    "Jozefa":"Jozefo",
    "Jozefina":"Jozefino",
    "Jozefína":"Jozefíno",
    "Judita":"Judito",
    "Julia":"Julio",
    "Júlia":"Júlio",
    "Juliana":"Juliano",
    "Juliána":"Juliáno",
    "Julianna":"Julianno",
    "Julie":"Julie",
    "Julija":"Julijo",
    "Justina":"Justino",
    "Justína":"Justíno",
    "Justýna":"Justýno",
    "Kamila":"Kamilo",
    "Karin":"Karin",
    "Karina":"Karino",
    "Karla":"Karlo",
    "Karolína":"Kájo",
    "Karolina":"Karolino",
    "Katarina":"Katarino",
    "Katarína":"Kataríno",
    "Katarzyna":"Katarzyno",
    "Katerina":"Katerino",
    "Kateryna":"Kateryno",
    "Kateřina":"Katko",
    "Katka":"Katko",
    "Katrin":"Katrin",
    "Khrystyna":"Khrystyno",
    "Klára":"Kláro",
    "Klaudia":"Klaudio",
    "Klaudie":"Klaudie",
    "Kornelie":"Kornelie",
    "Krista":"Kristo",
    "Kristina":"Kristino",
    "Kristína":"Kristíno",
    "Kristýna":"Kristýno",
    "Krystyna":"Krystyno",
    "Ksenia":"Ksenio",
    "Květa":"Květo",
    "Květoslava":"Květo",
    "Kvetoslava":"Kvetoslavo",
    "Květuše":"Květuše",
    "Květuška":"Květuško",
    "Lada":"Lado",
    "Ladislava":"Ladislavo",
    "Lan":"Lan",
    "Larisa":"Lariso",
    "Larysa":"Laryso",
    "Laura":"Lauro",
    "Lea":"Leo",
    "Leila":"Leilo",
    "Lena":"Leno",
    "Lenka":"Lenko",
    "Leona":"Leono",
    "Leontina":"Leontino",
    "Leontýna":"Leontýno",
    "Leopolda":"Leopoldo",
    "Leopoldina":"Leopoldino",
    "Lesya":"Lesyo",
    "Lia":"Lio",
    "Liana":"Liano",
    "Liběna":"Liběno",
    "Libuša":"Libušo",
    "Libuše":"Libuše",
    "Lidia":"Lidio",
    "Lidie":"Lidie",
    "Lidija":"Lidijo",
    "Lidiya":"Lidiyo",
    "Lidmila":"Lidmilo",
    "Liduše":"Liduše",
    "Liduška":"Liduško",
    "Lien":"Lien",
    "Lilia":"Lilio",
    "Liliana":"Liliano",
    "Liliya":"Liliyo",
    "Lina":"Lino",
    "Linda":"Lindo",
    "Linh":"Linh",
    "Liubov":"Liubov",
    "Liudmila":"Liudmilo",
    "Liudmyla":"Liudmylo",
    "Lívia":"Lívio",
    "Ljuba":"Ljubo",
    "Ljubov":"Ljubov",
    "Ljudmila":"Ljudmilo",
    "Loan":"Loan",
    "Ľubica":"Ľubico",
    "Lubomíra":"Lubomíro",
    "Ľubomíra":"Ľubomíro",
    "Lucia":"Lucio",
    "Lucie":"Lucko",
    "Luďka":"Luďko",
    "Ludmila":"Lído",
    "Ľudmila":"Ľudmilo",
    "Ludvika":"Ludviko",
    "Luisa":"Luiso",
    "Lydia":"Lydio",
    "Lýdia":"Lýdio",
    "Lydie":"Lydie",
    "Lýdie":"Lýdie",
    "Lyubov":"Lyubov",
    "Lyudmila":"Lyudmilo",
    "Lyudmyla":"Lyudmylo",
    "Magda":"Magdo",
    "Magdaléna":"Magdaléno",
    "Magdalena":"Magdo",
    "Mai":"Mai",
    "Maja":"Majo",
    "Mája":"Májo",
    "Malgorzata":"Malgorzato",
    "Malvína":"Malvíno",
    "Manuela":"Manuelo",
    "Marcela":"Marcelo",
    "Marcella":"Marcello",
    "Margareta":"Margareto",
    "Margarita":"Margarito",
    "Margit":"Margit",
    "Margita":"Margito",
    "Maria":"Mario",
    "Mária":"Mário",
    "Mariana":"Mariano",
    "Marianna":"Marianno",
    "Marianne":"Marianne",
    "Marie":"Maruško",
    "Mariia":"Mariio",
    "Marija":"Marijo",
    "Marika":"Mariko",
    "Marina":"Marino",
    "Mariya":"Mariyo",
    "Marketa":"Marketo",
    "Markéta":"Markéto",
    "Marta":"Marto",
    "Martina":"Marťo",
    "Maruše":"Maruše",
    "Maruška":"Maruško",
    "Maryana":"Maryano",
    "Maryna":"Maryno",
    "Matilda":"Matildo",
    "Matylda":"Matyldo",
    "Maya":"Mayo",
    "Melanie":"Melanie",
    "Melánie":"Melánie",
    "Melisa":"Meliso",
    "Melissa":"Melisso",
    "Mia":"Mio",
    "Michaela":"Míšo",
    "Michala":"Michalo",
    "Michelle":"Michelle",
    "Milada":"Milado",
    "Milana":"Milano",
    "Milena":"Mileno",
    "Milica":"Milico",
    "Miloslava":"Mílo",
    "Miluše":"Miluše",
    "Miluška":"Miluško",
    "Minh":"Minh",
    "Miriam":"Miriam",
    "Mirka":"Mirko",
    "Miroslava":"Mirko",
    "Monika":"Moniko",
    "Myroslava":"Myroslavo",
    "Naďa":"Naďo",
    "Naděje":"Naděje",
    "Nadezda":"Nadezdo",
    "Nadežda":"Nadeždo",
    "Naděžda":"Naděždo",
    "Nadiia":"Nadiio",
    "Nadiya":"Nadiyo",
    "Nancy":"Nancy",
    "Natali":"Natali",
    "Natalia":"Natalio",
    "Natália":"Natálio",
    "Natalie":"Natalie",
    "Natálie":"Natálie",
    "Nataliia":"Nataliio",
    "Natalija":"Natalijo",
    "Nataliya":"Nataliyo",
    "Natalja":"Nataljo",
    "Natallia":"Natallio",
    "Natalya":"Natalyo",
    "Nataša":"Natašo",
    "Nathalie":"Nathalie",
    "Nela":"Nelo",
    "Nella":"Nello",
    "Nelli":"Nelli",
    "Nelly":"Nelly",
    "Nelya":"Nelyo",
    "Nga":"Ngo",
    "Ngoc":"Ngoc",
    "Nhung":"Nhung",
    "Nicol":"Nicol",
    "Nicola":"Nicolo",
    "Nicole":"Nicole",
    "Nika":"Niko",
    "Nikita":"Nikito",
    "Nikol":"Nikol",
    "Nikola":"Nikolo",
    "Nikoleta":"Nikoleto",
    "Nina":"Nino",
    "Noemi":"Noemi",
    "Nora":"Noro",
    "OÄľga":"OÄľgo",
    "Oanh":"Oanh",
    "Oksana":"Oksano",
    "Oldřiška":"Oldřiško",
    "Oleksandra":"Oleksandro",
    "Olena":"Oleno",
    "Olesya":"Olesyo",
    "Olga":"Olgo",
    "Olha":"Olho",
    "Olina":"Olino",
    "Olivie":"Olivie",
    "Oluše":"Oluše",
    "Otília":"Otílio",
    "Otilie":"Otilie",
    "Oxana":"Oxano",
    "Pamela":"Pamelo",
    "Patricia":"Patricio",
    "Patrícia":"Patrício",
    "Patricie":"Patricie",
    "Paula":"Paulo",
    "Paulina":"Paulino",
    "Paulína":"Paulíno",
    "Pavla":"Pavlo",
    "Pavlina":"Pavlino",
    "Pavlína":"Pavlíno",
    "Petronela":"Petronelo",
    "Petronila":"Petronilo",
    "Petruše":"Petruše",
    "Petruška":"Petruško",
    "Phuong":"Phuong",
    "Polina":"Polino",
    "Radana":"Radano",
    "Radka":"Radko",
    "Radmila":"Radmilo",
    "Radomila":"Radomilo",
    "Radomíra":"Radomíro",
    "Radoslava":"Radoslavo",
    "Radovana":"Radovano",
    "Ráchel":"Ráchel",
    "Raisa":"Raiso",
    "Rebecca":"Rebecco",
    "Rebeka":"Rebeko",
    "Regina":"Regino",
    "Regína":"Regíno",
    "Renáta":"Renáto",
    "Renata":"Renčo",
    "René":"René",
    "Renée":"Renée",
    "Ria":"Rio",
    "Rita":"Rito",
    "Romana":"Romano",
    "Rosalie":"Rosalie",
    "Rosemarie":"Rosemarie",
    "Rostislava":"Rostislavo",
    "Rozalia":"Rozalio",
    "Rozália":"Rozálio",
    "Rozalie":"Rozalie",
    "Rozálie":"Rozálie",
    "Rozárie":"Rozárie",
    "Rudolfa":"Rudolfo",
    "Ruslana":"Ruslano",
    "Rut":"Rut",
    "Ruth":"Ruth",
    "Ružena":"Ruženo",
    "Růžena":"Růženo",
    "Sabina":"Sabino",
    "Sabrina":"Sabrino",
    "Samanta":"Samanto",
    "Samantha":"Samantho",
    "Sandra":"Sandro",
    "Sara":"Saro",
    "Sára":"Sáro",
    "Sarah":"Sarah",
    "Saša":"Sašo",
    "Silva":"Silvo",
    "Silvia":"Silvio",
    "Silvie":"Silvie",
    "Simona":"Simono",
    "Slavěna":"Slavěno",
    "Slavka":"Slavko",
    "Slávka":"Slávko",
    "Slavomila":"Slavomilo",
    "Slavomíra":"Slavomíro",
    "Sofia":"Sofio",
    "Sofie":"Sofie",
    "Sofiya":"Sofiyo",
    "Soňa":"Soňo",
    "Sonia":"Sonio",
    "Sonja":"Sonjo",
    "Sophia":"Sophio",
    "Sophie":"Sophie",
    "Stanislava":"Stanislavo",
    "Stanislawa":"Stanislawo",
    "Stefanie":"Stefanie",
    "Stela":"Stelo",
    "Stella":"Stello",
    "Svatava":"Svatavo",
    "Svatoslava":"Svatoslavo",
    "Světla":"Světlo",
    "Svetlana":"Svetlano",
    "Světlana":"Světlano",
    "Světluše":"Světluše",
    "Světluška":"Světluško",
    "Svitlana":"Svitlano",
    "Sylva":"Sylvo",
    "Sylvia":"Sylvio",
    "Sylvie":"Sylvie",
    "Šárka":"Šárko",
    "Šarlota":"Šarloto",
    "Štefana":"Štefano",
    "Štefania":"Štefanio",
    "Štefánia":"Štefánio",
    "Štefanie":"Štefanie",
    "Štěpánka":"Štěpánko",
    "Tam":"Tam",
    "Tamara":"Tamaro",
    "Táňa":"Táňo",
    "Taťána":"Táňo",
    "Taťana":"Taťano",
    "Tatiana":"Tatiano",
    "Tatjana":"Tatjano",
    "Taťjana":"Taťjano",
    "Tatsiana":"Tatsiano",
    "Tatyana":"Tatyano",
    "Teresa":"Tereso",
    "Tereza":"Terko",
    "Terezia":"Terezio",
    "Terézia":"Terézio",
    "Terezie":"Terko",
    "Tetiana":"Tetiano",
    "Tetyana":"Tetyano",
    "Thanh":"Thanh",
    "Thao":"Thao",
    "Thu":"Thu",
    "Thuy":"Thuy",
    "Timea":"Timeo",
    "Tina":"Tino",
    "Trang":"Trang",
    "Ulyana":"Ulyano",
    "Ursula":"Ursulo",
    "Urszula":"Urszulo",
    "Uršula":"Uršulo",
    "Václava":"Václavo",
    "Václavka":"Václavko",
    "Valentina":"Valentino",
    "Valentyna":"Valentyno",
    "Valentýna":"Valentýno",
    "Valeria":"Valerio",
    "Valéria":"Valério",
    "Valerie":"Valerie",
    "Valérie":"Valérie",
    "Valeriya":"Valeriyo",
    "Van":"Van",
    "Vanda":"Vando",
    "Vanesa":"Vaneso",
    "Vanessa":"Vanesso",
    "Vasylyna":"Vasylyno",
    "Vědunka":"Vědunko",
    "Věnceslava":"Věnceslavo",
    "Vendula":"Vendy",
    "Vendulka":"Vendulko",
    "Venuše":"Venuše",
    "Věra":"Věrko",
    "Vera":"Vero",
    "Verona":"Verono",
    "Veronica":"Veronico",
    "Veronika":"Verčo",
    "Věroslava":"Věroslavo",
    "Věruška":"Věruško",
    "Victoria":"Victorio",
    "Viera":"Viero",
    "ViktĂłria":"ViktĂłrio",
    "Viktoria":"Viktorio",
    "Viktorie":"Viktorie",
    "Viktoriia":"Viktoriio",
    "Viktorija":"Viktorijo",
    "Viktoriya":"Viktoriyo",
    "Viléma":"Vilémo",
    "Vilemína":"Vilemíno",
    "Vilma":"Vilmo",
    "Viola":"Violo",
    "Violeta":"Violeto",
    "Vira":"Viro",
    "Vita":"Vito",
    "Vitaliya":"Vitaliyo",
    "Vítězslava":"Víťo",
    "Vivien":"Vivien",
    "Vladana":"Vladano",
    "Vladěna":"Vladěno",
    "Vladimíra":"Vladimíro",
    "Vladislava":"Vladislavo",
    "Vlasta":"Vlasto",
    "Vlastimila":"Vlastimilo",
    "Vlastislava":"Vlastislavo",
    "Vojtěška":"Vojtěško",
    "Vratislava":"Vratislavo",
    "Waltraud":"Waltraud",
    "Wanda":"Wando",
    "Xenie":"Xenie",
    "Yana":"Yano",
    "Yaroslava":"Yaroslavo",
    "Yen":"Yen",
    "Yevheniya":"Yevheniyo",
    "Yulia":"Yulio",
    "Yuliya":"Yuliyo",
    "Yveta":"Yveto",
    "Yvetta":"Yvetto",
    "Yvona":"Yvono",
    "Yvonna":"Yvonno",
    "Yvonne":"Yvonne",
    "Zdena":"Zdeno",
    "Zděna":"Zděno",
    "Zdenka":"Zdenko",
    "Zdeňka":"Zdeňko",
    "Zděnka":"Zděnko",
    "Zdislava":"Zdislavo",
    "Zhanna":"Zhanno",
    "Zina":"Zino",
    "Zinaida":"Zinaido",
    "Zita":"Zito",
    "Zlata":"Zlato",
    "Zlatica":"Zlatico",
    "Zlatuše":"Zlatuše",
    "Zlatuška":"Zlatuško",
    "Zoe":"Zoe",
    "Zofia":"Zofio",
    "Zoja":"Zojo",
    "Zora":"Zoro",
    "Zorka":"Zorko",
    "Zuzana":"Zuzko",
    "Žaneta":"Žaneto",
    "Želmíra":"Želmíro",
    "Žofia":"Žofio",
    "Žofie":"Žofie",
  };
}