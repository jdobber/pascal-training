program BaumBedingung(input, output);

const 
 (* unser Beispielbaum *)
  ANZAHL_A = 7;
  KEYS_A: array [0..ANZAHL_A-1] of integer = (11, 5, 13, 12, 8, 100, 14);
  KEYS_B: array [0..ANZAHL_A-1] of integer = (11, 8, 15, 9, 12, 100, 100);
  (* Knoten mit 100 sind nur Pseudo-Knoten, damit der Baum einfach konstruiert werden kann *)
  
type 
	(* Datenstrukturen aus der Aufgabe *)
	tNatZahl = 1..maxint; 
	tRefBinBaum = ^tBinBaum; 
	tBinBaum = record 
             Wert: tNatZahl;
             links: tRefBinBaum; 
             rechts: tRefBinBaum 
    end;

var 
	root: tRefBinBaum; (* unsere Referenz auf das Wurzelelement *)
 
(* 
* druckt den Baum t auf den Bildschirm gekippt aus
* adaptiert aus Wirth; Algorithmen und Datenstrukturen; 3. Auflage, 1983, S. 224 ff.
*)
Procedure druckeBaum(t: tRefBinBaum; h: integer);

Var i: integer;
Begin
  If t <> Nil Then
    Begin
      druckeBaum(t^.rechts, h+1);
      For i := 1 To h*3 Do
        Begin
          write(' ');
        End;
      writeln(t^.Wert:4);
      druckeBaum(t^.links, h+1)
    End
End;

(*
*  baut einen ausgeglichenen binaeren Baum auf 
*  adaptiert aus Wirth; Algorithmen und Datenstrukturen; 3. Auflage, 1983, S. 224 ff.
*)
Function baum(n: integer; elements: Array Of integer): tRefBinBaum;

Var 
  newnode: tRefBinBaum;
  nl, nr: integer;
Begin
  If n = 0 Then baum := Nil (* leerer Baum *)
  Else
    Begin
   (* Baum aufteilen in Wurzel, linker und rechter Teilbaum *)
      nl := n Div 2;
      nr := n - nl - 1;

   (* neuen Knoten erzeugen und rekursiv absteigen *)
      new(newnode);
      newnode^.Wert := elements[0];      
      newnode^.links := baum(nl, elements[1..nl]);
      newnode^.rechts := baum(nr, elements[nl+1..nl+1+nr]);
      baum := newnode;
    End
End;

(*
* 	Die Loesung. 
*)
function BlattMax( inRefWurzel: tRefBinBaum; inPfadMax: integer) : boolean;
	var
		Ergebnis: boolean;
		max: integer;
		
begin
	max := inPfadMax;

	if inRefWurzel = nil then
		(* wir sind von einem Blatt gekommen *)
		Ergebnis := true
	else		
		if (inRefWurzel^.links = nil) and (inRefWurzel^.rechts = nil) then
			(* Ist inRefWurzel ein Blatt ? *)
			if inRefWurzel^.Wert < max then 
				Ergebnis := false
			else
				Ergebnis := true
		else
		begin
			(* oder ein Knoten ? *)
			if inRefWurzel^.Wert > max then 
				max := inRefWurzel^.Wert;
			
			(* rekursiv nach links und dann nach rechts absteigen und
			* dabei die Ergebnisse aus den Teilbaumen mit und verknuepfen *)
			Ergebnis := BlattMax(inRefWurzel^.links, max) and 
						BlattMax(inRefWurzel^.rechts, max);			
		end;
		
	BlattMax := Ergebnis;	
end;

(* Hauptprogramm *)
begin

	(* Wurzel und Baum aufbauen initialisieren *)
	root := baum(ANZAHL_A, KEYS_A);   
	
	(* Ausgabe des Baums *)
	writeln('Baum:');
	druckeBaum(root, 0);  
	writeln('Bedingung fuer Baum 1 erfuellt? :', BlattMax(root, 1));
  
	(* Wurzel und Baum aufbauen initialisieren *)
	root := baum(ANZAHL_A, KEYS_B);   
	
	(* Ausgabe des Baums *)
	writeln('Baum:');
	druckeBaum(root, 0);  
	writeln('Bedingung fuer Baum 2 erfuellt? :', BlattMax(root, 1));
  
end.
