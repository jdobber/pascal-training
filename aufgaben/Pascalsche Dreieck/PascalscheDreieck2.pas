Program PascalscheDreieck(input, output);
(*
* Wichtig: Wir nutzen hier die doppelt verkettete Liste.
*)

Type 
 (* unsere Typen aus der Aufgabenstellung *)
  tRefDVElement = ^tDVElement;
  tDVElement = Record
    wert: integer;
    next,prev: tRefDVElement
  End;

Var 
 (* unsere Zeiger fuer unsere liste *)
  kopf: tRefDVElement;
  i,j: integer;

(*
* push: fuegt ein Element nach dem Element z ein und gibt einen
* Zeiger auf das neue Element zurueck
* 
*)
function push(z: tRefDVElement; w: integer): tRefDVElement;
Var 
	p: tRefDVElement;
	
Begin

 (* neues Element anlegen und Wert speichern *)
  new(p);
  p^.wert := w; (* Wert speichern *)

  If z = Nil Then (* wenn leere Liste *)
    Begin
      p^.prev := Nil; (* erstes Element hat keinen Vorgaenger *)
    End
  Else   (* sonst, neues Element anfuegen *)
    Begin
   (* Element aus Parameterliste wird zum Vorgaenger des neuen Elements *)
      p^.prev := z;

   (* neues Element wird zum Nachfolger des Elements aus Parameterliste *)
      z^.next := p;

    End;

  p^.next := Nil; (* es gibt noch keinen Nachfolger *)

  push := p;
End;

(*
*  nimmt eine beliebige Liste (Zeile) aus dem Pascalschen Dreieck und
* generiert die naechste Zeile und gibt diese als neue Liste zurueck 
* 
*)
Function ListeAufbauen(inListe: tRefDVElement): tRefDVElement;

Var 
  kopf, schwanz, z: tRefDVElement;
 
Begin
  z := inListe; 		(* kann auf ein beliebiges Element in der Liste zeigen *)
  kopf := inListe;		(* zeigt immer auf den Anfang der neuen Liste *)
  schwanz := nil;		(* zeigt immer auf das letze Element der neuen Liste *)
  
  (* Fall 1: leere Liste -> 1 *)
  if z = nil then kopf := push(nil, 1)
  (* Fall 2: Liste mit einem Element -> 1 1 *)
  else if z^.next = nil then schwanz := push(kopf, 1)
  else (* Fall 3: Liste mit mindestens zwei Elementen *)
  begin
	kopf := push(nil, 1);	(* neue Liste immer mit 1 anfangen *)
	schwanz := kopf;
	z := inListe;
	(* laufe ueber Liste *)
	while z^.next <> nil do
	begin	
		schwanz := push(schwanz, z^.wert + z^.next^.wert);	(* addiere und pushe *)
		z := z^.next;
	end;
	schwanz := push(schwanz, 1); (* neue Liste immer mit 1 beenden *)
  end;
  
  ListeAufbauen := kopf;
End;

(* 
* druckt die Liste aus 
*)
Procedure druckeListe(inListe: tRefDVElement);
Var 
	z: tRefDVElement;

Begin
  z := inListe;
  While z <> Nil Do
    Begin
      write(z^.wert:4);
      z := z^.next;
    End;
End;


(* Hauptprogramm *)
Begin

	kopf := nil;

	for i := 10 downto 1 do
	begin

		(* neue Liste aufbauen und den Anfang merken; die Referenz auf die alte Liste
		* geht verloren *)
		kopf := ListeAufbauen(kopf);
	  
		for j := 1 to i do write('  ');	(* Leerzeichen fuer die Symmetrie *)
	  
		druckeListe(kopf);
		writeln;
	  
	end;

End.
