
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
* 	Die Musterloesung
* 
*)
Function Baumpfad(inWurzel : tRefBBKnoten;
                  inSuchwert : integer): tRefElement;
{sucht einen Wert im Baum und gibt eine Liste aller Werte auf dem 
  Pfad zum gesuchten Wert zurueck }

Var 
  BBKnoten : tRefBBKnoten;
  LoeschElement,
  ListenAnfang,
  ListenEnde: tRefElement;
  gefunden : boolean;

Begin
  BBKnoten := inWurzel;
  gefunden := false;
  ListenAnfang := Nil;
  While (BBKnoten <> Nil) And (Not gefunden) Do
    Begin
    { 1.) ** Wert von BBKnoten in Liste einfügen ** }
      If ListenAnfang = Nil Then
    { erstes Listenelement erzeugen }
        Begin
          new (ListenAnfang);
          ListenEnde := ListenAnfang
        End
      Else
    {neues Listenelement anhaengen}
        Begin
          new (ListenEnde^.next);
          ListenEnde := ListenEnde^.next
        End;
      ListenEnde^.info := BBKnoten^.info;
      ListenEnde^.next := Nil;
    {2.) ** Suchwert gefunden? Falls nein, Suchbaum weiter durchlaufen ** }
      If inSuchwert = BBKnoten^.info Then
        gefunden := true
      Else
        If inSuchwert < BBKnoten^.info Then
          BBKnoten := BBKnoten^.links
      Else
        BBKnoten := BBKnoten^.rechts
    End; {while}
  {3.) ** Falls nicht gefunden, aufgebaute Liste loeschen **}
  If Not gefunden Then
    While ListenAnfang <> Nil Do
      Begin
        LoeschElement := ListenAnfang;
        ListenAnfang := ListenAnfang^.next;
        dispose(LoeschElement)
      End;
  {4.) ** Ergebnisrückgabe **}
  Baumpfad := ListenAnfang
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
