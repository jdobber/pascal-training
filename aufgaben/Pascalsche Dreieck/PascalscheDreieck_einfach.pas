program PascalscheDreieck(input, output);

type 
	tRefListe = ^tListe; 
	tListe = record 
		wert: integer; 
		next: tRefListe             
	end; 

var 
  refListeA, refListeB, refListeC: tRefListe; (* unsere Zeiger fuer unsere listen *)
    
(*
* fuegt an das Ende einer Liste ein neues Element ein und
* gibt eine Referenz auf das letzte Element der neuen Liste zurueck
*)
function push(inRefListe: tRefListe; inWert: integer): tRefListe;
var	
	refNeu: tRefListe;

begin
	new(refNeu);
	refNeu^.wert := inWert;
	refNeu^.next := nil;
	
	if inRefListe <> nil then
		inRefListe^.next := refNeu;
		
	push := refNeu;
end;

(* Die Loesung *)
function ListeAufbauen(inRefListe: tRefListe): tRefListe;
var
	(*
	* anfang: 	Zeiger auf erstes Element der neuen Liste
	* z:		Hilfszeiger um durch inRefListe zu laufen
	* b:		Hilfszeiger für das aktuelle Element der neuen Liste
	* elem:		zum Anlegen neuer Listenelemente
	*)
	anfang, z, b, elem: tRefListe;

begin
	(* erstes Element aufbauen *)
	new(anfang);
	anfang^.wert := 1;
	anfang^.next := nil;
	b := anfang;
	
	(* durch Ausgangliste laufen *)
	z := inRefListe;
	while (z <> nil) and (z^.next <> nil) do 
	begin
		new(elem);
		elem^.wert := z^.wert + z^.next^.wert;
		elem^.next := nil;
		b^.next := elem;
		b := elem;
		z := z^.next;
	end;
	
	(* letztes Element anfügen *)
	new(elem);
	elem^.wert := 1;
	elem^.next := nil;
	b^.next := elem;
	
	ListeAufbauen := anfang;
end;

(* 
* druckt die Liste aus 
*)
procedure druckeListe(inListe: tRefListe);
var 
	z: tRefListe;

begin
	z := inListe;
	while z <> nil do
	begin
		write(z^.wert:4);
		z := z^.next;
	end;
	writeln;
end;


(* Hauptprogramm *)
begin

	(* Liste mit erstem Element erstellen -> [1] *)
	refListeA := push(nil, 1);
	(* sukzessiv 4, 6, 4 und 1 anhaengen *)
	push( push( push( push( refListeA, 4 ), 6 ), 4 ), 1 );
	
	(* Liste ausgeben *)
	druckeListe(refListeA);
	
	(* Ergebnisliste erzeugen *)
	refListeB := ListeAufbauen(refListeA);
	
	(* Ergebnisliste ausgeben *)
	druckeListe(refListeB);
	
	(* Ergebnisliste erzeugen *)
	refListeC := ListeAufbauen(refListeB);
	
	(* Ergebnisliste ausgeben *)
	druckeListe(refListeC);
	
end.
