
Program Baumpfad(input, output);

Const 
 (* unser Beispielbaum *)
  ANZAHL_KNOTEN = 21;
  KEYS: array [1..ANZAHL_KNOTEN] Of integer = 
                                              (8,9,11,15,19,20,21,7,3,2,1,5,6,4,
                                               13,14,10,12,17,16,18
                                              );

Type 
 (* Datenstrukturen aus der Aufgabe *)
  tRefBBKnoten = ^tBBKnoten;
  tBBKnoten = Record
    info: integer;
    links,
    rechts: tRefBBKnoten
  End;
  tRefElement = ^tElement;
  tElement = Record
    info: integer;
    next: tRefElement
  End;

Var 
  root: tRefBBKnoten;
(* unsere Referenz auf das Wurzelelement *)
  liste: tRefElement;
(* unsere Referenz auf unsere Liste *)
  i: integer;
(* Laufvariable *)

(* 
* druckt den Baum t auf den Bildschirm gekippt aus
* adaptiert aus Wirth; Algorithmen und Datenstrukturen; 3. Auflage, 1983, S. 224 ff.
*)
Procedure druckeBaum(t: tRefBBKnoten; h: integer);

Var i: integer;
Begin
  If t <> Nil Then
    Begin
      druckeBaum(t^.rechts, h+1);
      For i := 1 To h*3 Do
        Begin
          write(' ');
        End;
      writeln(t^.info:4);
      druckeBaum(t^.links, h+1)
    End
End;

(*
*  Einfuegen des Elements x in den Baum t durch Suche 
*  adaptiert aus Wirth; Algorithmen und Datenstrukturen; 3. Auflage, 1983, S. 224 ff.
*)
Procedure einfuegenBaum(x: integer; Var t: tRefBBKnoten);
Begin
  If t = Nil Then
    Begin
      new(t);
      t^.info := x;
      t^.links := Nil;
      t^.rechts := Nil
    End
  Else If x < t^.info Then einfuegenBaum(x, t^.links)
  Else If x > t^.info Then einfuegenBaum(x, t^.rechts);
End;

(*
* 	Unsere Lösung
* 
*)
Function Baumpfad(inWurzel : tRefBBKnoten;
                  inSuchwert : integer): tRefElement;
{sucht einen Wert im Baum und gibt eine Liste aller Werte auf dem 
  Pfad zum gesuchten Wert zurueck }
Var 
	liste : tRefElement;	(* zeigt auf den Listenanfang *)
	gefunden: boolean;
	k: tRefBBKnoten;		(* unser aktueller Knoten *)
	z, elem: tRefElement;	(* Hilfszeiger für die Liste *)
	
Begin
	gefunden := false;

	(* Liste initialisieren *)
	liste := nil;
	
	(* Element im Baum suchen und besuchte Elemente der Liste hinzufügen *)
	k := inWurzel;
	while not gefunden and (k <> nil) do
	begin
		(* neues Element zur Liste hinzufügen *)
		new(elem);
		elem^.info := k^.info;
		elem^.next := nil;
		if liste = nil then (* leere Liste ? *)
		begin 
			liste := elem;
			z := liste;
		end;
		z^.next := elem;
		z := z^.next;
		
		(* durch Baum laufen *)
		if k^.info = inSuchwert then
			gefunden := true
		else
			if inSuchwert < k^.info then
				k := k^.links
			else
				k:= k^.rechts;		
	end;  
  
	(* Liste löschen, falls Element nicht gefunden *) 
	(*
	if not gefunden then
	begin
		while liste <> nil do
		begin
			z := liste^.next;
			dispose(liste);
			liste := z;
		end;
	end; *)
	if (z^.info = inSuchwert) then
		Baumpfad := liste
	else
	begin
		z := liste;
		while z <> nil do
		begin
			elem := z^.next;
			dispose(z);
			z := elem;
		end;
		Baumpfad := nil;
	end;
	
	(* Liste zurückgeben *)
	(*Baumpfad := liste;*)
End; { Baumpfad }

(* 
* druckt die Liste l aus
*)
Procedure druckeListe(l: tRefElement);
Begin
 (* checke auf leere Liste *)
  If l = Nil Then write('Das Element wurde nicht gefunden. Die Liste ist leer.')
  ;

 (* laufe ueber die Liste *)
  While l <> Nil Do
    Begin
      write(l^.info:4);
      l := l^.next;
    End;

  writeln;
End;


(* Hauptprogramm *)
Begin
  root := Nil;
(* Wurzel initialisieren *)

 (* Keys nach und nach einfuegen *)
  For i := 1 To ANZAHL_KNOTEN Do
    Begin
      einfuegenBaum(KEYS[i], root)
    End;

 (* Ausgabe des Baums *)
  writeln('Baum:');
  druckeBaum(root, 0);

 (* Suche Element 1 -> [8,7,3,2,1] *)
  writeln;
  writeln('Suche Element 1:');
  liste := Baumpfad(root, 1);
  druckeListe(liste);

 (* Suche Element 12 -> [8,9,11,15,13,12] *)
  writeln;
  writeln('Suche Element 12:');
  liste := Baumpfad(root, 12);
  druckeListe(liste);

 (* Suche Element 1000 -> [] *)
  writeln;
  writeln('Suche Element 1000:');
  liste := Baumpfad(root, 1000);
  druckeListe(liste);

End.
