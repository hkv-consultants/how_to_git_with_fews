# How to Git

Deze repository bevat een beginners handleiding over het gebruik van Git, een versiebeheersysteem.
Het is vooral gericht op hoe je Git kunt gebruiken in combinatie met FEWS projecten, al zijn de commando's en manier van werken generiek toepasbaar
Deze handleiding is veelal gebaseerd op onze ervaringen maar ook vooral externe bronnen die nuttig zijn om meer te leren buiten wat hier beschreven staat.

## Bronnen

Het [NL eScience Center](https://www.esciencecenter.nl/training-materials/) heeft verschillende trainingen. Deze variëren van beginner tot gevorderd en zijn ook breder dan alleen git. Twee bronnen die zijn gebruiken [Carpentries incubator](https://carpentries-incubator.github.io/collaborative-git-and-github-lesson/index.html), die gebaseerd is op de [Coderefinery](https://coderefinery.github.io/github-without-command-line/basics/) les. Veel van de uitleg heb ik over genomen, vertaald en aangepast naar onze situatie. Hierbij heb ik soms expres details weggelaten om het compacter te houden.

Neem deze vooral een keer door of gebruik ze om te zoeken naar antwoorden op specifieke vragen. Er staan ook veel voorbeelden en nuttig tips in.

## Waarom?

Allereerst: waarom zou je git gebruiken? In het algemeen is het een hele nuttig tool om:

- Terug te kunnen bij fouten.
- Makkelijk nieuwe functionaliteiten te kunnen ontwikkelen, zonder dat het veel moeite kost om terug dit ongedaan te maken.
- Te herleiden waar fouten in het verleden ontstaan, en snel te zien door wie en waarom iets is aangepast.
- Samenwerken te werken met anderen, zonder dat je elkaars werk overschrijft of per ongeluk verwijdert.

Specifiek voor FEWS zorgt het er ook voor dat je snel aanpassingen kan doorvoeren waar nodig zonder dat je bang hoeft te zijn dat je iets kapot maakt. FEWS heeft dit al deels ingebouwd met de Config Manager (CM), maar in een team is dit niet altijd even handig. Door de laatste wijzigingen in Git te hebben staan, kan je altijd werken met de juiste versie. 

## Wat is `Git`, `GitHub` en `DevOps`?

### Git

- Een tool die snapshots (of moment opnamen) kan vastleggen en synchroniseren.
- Het is niet de enige tool die snapshots kan vastleggen (andere populaire tools zijn Subversion en Mercurial).
- Git is niet alleen een tool, maar ook een formaat dat door veel verschillende tools gelezen kan worden.

### `GitHub` en `DevOps`

- Een dienst die hosting biedt voor Git repositories met een gebruiksvriendelijke webinterface.
- Het is niet de enige dienst die dit biedt, andere populaire diensten zijn GitLab en Bitbucket. Binnen waterschappen wordt vaak DevOps gebruikt.

## Repositories, branches, Commits , clones

- `repository`: Het project, bevat alle data en geschiedenis (commits, branches, tags). In ons geval is dit er maar eentje met het FEWS project. Voor een WIS zou je wel een andere repository gebruiken dan voor het BOS.
- `branch`: Een 'Onafhankelijke ontwikkellijn', vaak noemen we de hoofdontwikkellijn ~~master~~ main. Wij kennen: `main`, `test`, `ontwikkel`, `ontwikkel_<naam>` en soms ook `ontwikkel_<naam>_<feature>`. Dit is ook de volgorde van samenvoegen. In `main` zitten de wijzigingen die draaien in productie omgeving, in `test` die draaien op de test omgeving. In `ontwikkel` staat alles wat klaar is om naar `test` te gaan, maar je voor wat voor reden nog niet heb doorgezet. `Ontwikkel_<naam>` is een persoonlijke ontwikkelomgeving waar je aanpassingen kan maken zonder dat dit direct invloed heeft op anderen. Alles met `Ontwikkel_<naam>_..` is ook persoonlijk, vaak voor een specifieke aanpassing.
- `commit`: Momentopname van het project, krijgt een unieke identificatie (bijv. c7f0e8bfc718be04525847fc7ac237f470add76e).
- `cloning`: Het kopiëren van de hele repository naar je laptop - de eerste keer. Het is niet nodig om elk bestand één voor één te downloaden.

## Basis stappen plan

Hier is een basis stappenplan beschreven. Je kan met verschillende tools werken, maar de stappen blijven hetzelfde. We gaan er hier vanuit dat je de command line gebruikt, maar de knoppen heten vaak hetzelfde in gui's zoals bijvoorbeeld [Tortoise Git](https://tortoisegit.org/).

### Niet altijd

Dit zijn stappen die je niet altijd hoeft te doen:

>1. `git clone <url>`: Kopieer de repository naar je laptop (alleen de eerste keer).
>1. `git checkout <branch>`: Ga naar de juiste branch (bijv. `ontwikkel_<naam>`). (of `git switch <branch>`), afhankelijk van hoe je het opzet is dit niet altijd nodig.

## Altijd

Voor elke toevoeging is het volgende nodig:

1. `git pull`: Haal de laatste wijzigingen op van de remote repository. Ook wel bekend als `sync` in gui's.
1. `git add <filename>`: selecteer de bestanden om klaar te zetten. In sommige gevallen heb je wijzigingen gedaan maar wil je deze niet mee nemen.
1. `git commit -m '<message>'`: Maak een momentopname van de geselecteerde bestanden met een korte omschrijving van wat je hebt aangepast.
1. `git push`: Stuur de wijzigingen naar de remote repository.

### Samenvoegen van branches

Het samenvoegen van branches kan via de `.bat` scripts die hier te vinden zijn. Zo hoef je de commando's niet allemaal zelf in te typen.

<details>
<summary>
<b>Optioneel</b>: korte uitleg van de stappen die worden uitgevoerd in de scripts.
</summary>

- Beide branches worden opgehaald:

>```git
>git checkout %BRANCH_FROM%
>git pull
>git checkout %BRANCH_TO%
>git pull
>```

- De verschillen worden per regel getoond.

>```git
>git diff %BRANCH_TO%..%BRANCH_FROM%
>```

- Vervolgens wordt er een merge gedaan in een tijdelijk branch.

>```git
>git checkout -b %BRANCH_TO%_temp %BRANCH_TO%
>git merge %BRANCH_FROM%
>git checkout %BRANCH_TO%
>git branch -D %BRANCH_TO%_temp
>```

- Als laatste worden de wijzigingen definitief doorgezet:

>```git
>git merge %BRANCH_FROM%
>git push
>```

</details>

## Aan de slag

Het beste leer je door er gewoon mee te werken.
Gebruik deze repository om te oefenen.
Er is een `FEWS` map, deze volgt ongeveer de structuur zoals we het binnen FEWS project en gebruiken.
Maak een bekijk de verschillende branches, oefen met de commando's en probeer een paar wijzigingen door te voeren vanuit `ontwikkel_<naam>` naar `ontwikkel` en uiteindelijk naar `test` en `main`.
Je kan de map `docs` en `.github` negeren, hier staat alleen wat python magie die hier een mooie pagina van maakt.

Heb je nog vragen? Schroom niet om ze te stellen!
