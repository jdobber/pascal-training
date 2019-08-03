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
	head: tRefListe;
	z: tRefListe;
	tail: tRefListe;

begin
	z := inRefListe;	
	head := push(nil, 1);	(* Liste [1] erstellen *)
	tail := head;			(* erstes Element ist auch letztes Element *)
	
	(* durch Liste laufen *)
	while z^.next <> nil do
	begin
		(* neues Element an letztes Element anhaengen *)
		tail := push(tail, z^.wert + z^.next^.wert);
		
		(* zum naechsten Element wechseln *)
		z := z^.next;
	end;
		
	tail := push(tail, 1); (* [...] -> [..., 1] *)
	
	ListeAufbauen := head;
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
