
Program DVListenElementEntfernen(input, output);

Const 
 (* unsere Liste *)
  ANZAHL = 5;
  KEYS: array [0..ANZAHL-1] Of integer = (7,3,5,3,1);

Type 
 (* unsere Typen aus der Aufgabenstellung *)
  tRefDVElement = ^tDVElement;
  tDVElement = Record
    wert: integer;
    next,prev: tRefDVElement
  End;

Var 
 (* unsere Zeiger fuer unsere liste *)
  kopf, schwanz: tRefDVElement;

  e: integer;

Procedure ListeAufbauen(Var ioKopf: tRefDVElement;
                        Var ioSchwanz: tRefDVElement;
                        werte: Array Of integer);

Var 
  kopf, zeiger: tRefDVElement;
  i: integer;

Procedure push(Var z: tRefDVElement; w: integer);

Var p: tRefDVElement;
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

 (* das neue Element wird zum letzten Element *)
  z := p;
End;

Begin
  zeiger := Nil;
  kopf := Nil;

  For i := 0 To ANZAHL-1 Do
    Begin
      push(zeiger, KEYS[i]);
      If i = 0 Then kopf := zeiger;
    End;

  ioKopf := kopf;
  ioSchwanz := zeiger;
End;

Procedure druckeListeVorwaerts(inListe: tRefDVElement);

Var z: tRefDVElement;
Begin
  z := inListe;
  While z <> Nil Do
    Begin
      write(z^.wert:4);
      z := z^.next;
    End;
End;

Procedure druckeListeRueckwaerts(inListe: tRefDVElement);

Var z: tRefDVElement;
Begin
  z := inListe;
  While z <> Nil Do
    Begin
      write(z^.wert:4);
      z := z^.prev;
    End;
End;

(* 
* unsere selbst gefundene Loesung, die etwas anders ist als die Musterloesung
*)
Procedure DVListenElementEntfernen(Var ioListe: tRefDVElement;
                                   inSuchwert: integer);

Var 
  z: tRefDVElement;
  gefunden: boolean;

Begin

  z := ioListe;
  gefunden := false;

 (* durch Liste laufen und falls gefunden Schleife abbrechen *)
  While (z <> Nil) And Not gefunden Do
    Begin
      If z^.wert = inSuchwert Then gefunden := true
      Else z := z^.next;
    End;

 (* wenn gefunden *)
  If gefunden Then
    Begin
      if z^.prev <> nil then z^.prev^.next := z^.next;
      if z^.next <> nil then z^.next^.prev := z^.prev;
      if z^.prev = nil then ioListe := z^.next;
      dispose(z);
    End;

End;


(* Hauptprogramm *)
Begin

(* Element 1000 loeschen *)
  writeln('Liste neu aufbauen');
  ListeAufbauen(kopf, schwanz, KEYS);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');
  druckeListeRueckwaerts(schwanz);
  writeln;

  e := 1000;
  writeln('erstes Element ', e:1, ' loeschen:');
  DVListenElementEntfernen(kopf, e);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');
  druckeListeRueckwaerts(schwanz);
  writeln;writeln('************************************');

 (* Element 3 loeschen *)
  writeln('Liste neu aufbauen');
  ListeAufbauen(kopf, schwanz, KEYS);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');
  druckeListeRueckwaerts(schwanz);
  writeln;

  e := 3;
  writeln('erstes Element ', e:1, ' loeschen:');
  DVListenElementEntfernen(kopf, e);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');
  druckeListeRueckwaerts(schwanz);
  writeln;writeln('************************************');

 (* Element 7 (der Kopf) loeschen *)
  writeln;
  writeln('Liste neu aufbauen');
  ListeAufbauen(kopf, schwanz, KEYS);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');
  druckeListeRueckwaerts(schwanz);
  writeln;

  e := 7;
  writeln('erstes Element ', e:1, ' loeschen:');
  DVListenElementEntfernen(kopf, e);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');
  druckeListeRueckwaerts(schwanz);
  writeln;writeln('************************************');

 (* Element 1 (der Schwanz) loeschen *)
  writeln;
  writeln('Liste neu aufbauen');
  ListeAufbauen(kopf, schwanz, KEYS);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');
  druckeListeRueckwaerts(schwanz);
  writeln;

  e := 1;
  writeln('erstes Element ', e:1, ' loeschen:');
  DVListenElementEntfernen(kopf, e);

  writeln('Liste von Anfang bis Ende:');
  druckeListeVorwaerts(kopf);
  writeln;

  writeln('Liste von Ende bis Anfang:');

(* VORSICHT: 
	* schwanz zeigt noch auf den alten Schwanz, aber das Element haben
	* wir gerade entfernt. Der Zeiger kopf wird durch unsere Prozedur aktualisiert,
	* aber nicht der Zeiger schwanz. Deswegen hier die Ausgabe auskommentiert.
	*)
 { druckeListeRueckwaerts(schwanz); }
  writeln;

End.
