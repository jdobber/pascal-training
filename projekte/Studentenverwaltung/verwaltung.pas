program Studentenverwaltung(input, ouput);

(* Konstanten, Typen und globale Variablen *)
type
	tString = string[20];
	tRefStud = ^tStud;
	tStud = record
				name: tString;
				alter: integer;
				geschlecht: char;
				beurlaubt: boolean;
				next: tRefStud;
			end;

var
	studListAnfang : tRefStud;
	student : tRefStud;
	eingabe : tString;

(* Prozeduren und Funktion *)

procedure NeuerStudent(var ioRefStud: tRefStud;
					name: tString;
					alter: integer;
					geschlecht: char;
					beurlaubt: boolean);
(* 
* Legt einen neuen Studenten an und fügt ihn als erstes Element 
* in die Liste ein 
*)
var 
	neu : tRefStud;
	 
begin
	new(neu);
	neu^.name := name;
	neu^.alter := alter;
	neu^.geschlecht := geschlecht;
	neu^.beurlaubt := beurlaubt;
	neu^.next := ioRefStud;
	ioRefStud := neu;
end;

procedure druckeStudent(inRefStud: tRefStud);
(* 
* druckt einen Studenten aus
*)
begin
	if inRefStud <> nil then
	begin
		write(inRefStud^.name:21);
		write(inRefStud^.alter:4);
		write(inRefStud^.geschlecht:4);
		write(inRefStud^.beurlaubt:8);
		writeln;
	end;
end;

procedure druckeAlle(inRefStud: tRefStud);
(* 
* druckt alle Studenten aus
*)
var
	z : tRefStud;
begin
	z:= inRefStud;
	while z <> nil do
	begin		
		druckeStudent(z);				
		z := z^.next;
	end;
end;

function sucheStudent(inRefStud: tRefStud; name : tString): tRefStud;
(* sucht einen Studenten und gibt einen Zeiger auf den Studenten zurück *)
var
	z : tRefStud;
	gefunden: boolean;
begin
	z:= inRefStud;
	gefunden := false;
	while (z <> nil) and not gefunden do
	begin		
		if z^.name = name then
			gefunden := true
		else						
			z := z^.next;
	end;	
	sucheStudent := z;
end;

(* Hauptprogramm *)
begin

	studListAnfang := nil;

	(* Studenten erzeugen *)
	NeuerStudent(studListAnfang, 'Roman', 25, 'm', false);
	NeuerStudent(studListAnfang, 'Romy', 22, 'f', true);
	NeuerStudent(studListAnfang, 'Sabine', 32, 'f', false);
	NeuerStudent(studListAnfang, 'Thomas', 40, 'm', false);
	NeuerStudent(studListAnfang, 'Jonas', 19, 'm', false);
	
	(* alle Studenten ausgeben *)
	writeln('Alle Studenten: ');
	druckeAlle(studListAnfang);
	
	(* Suche nach einem Studenten *)
	writeln('Suche: ');
	readln(eingabe);
	student := sucheStudent(studListAnfang, eingabe);
	if student = nil then
		writeln('Nicht vorhanden');
	druckeStudent(student);


end.
