program Spiegeln(input, output);

const 
  (* unser Beispielbaum *)
  ANZAHL_KNOTEN = 7;
  KEYS: array [1..ANZAHL_KNOTEN] Of integer = (27,3,1,15,39,30,41);
  
type 
	(* Datenstrukturen aus der Aufgabe *)
	tRefKnoten = ^tKnoten;
	tKnoten = record
				info: integer;
				links,
				rechts: tRefKnoten
			  end;

var 
	root: tRefKnoten; (* unsere Referenz auf das Wurzelelement *)
 
(* 
* druckt den Baum t auf den Bildschirm gekippt aus
* adaptiert aus Wirth; Algorithmen und Datenstrukturen; 3. Auflage, 1983, S. 224 ff.
*)
Procedure druckeBaum(t: tRefKnoten; h: integer);

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
*  baut einen ausgeglichenen binaeren Baum auf 
*  adaptiert aus Wirth; Algorithmen und Datenstrukturen; 3. Auflage, 1983, S. 224 ff.
*)
Function baum(n: integer; elements: Array Of integer): tRefKnoten;

Var 
  newnode: tRefKnoten;
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
      newnode^.info := elements[0];      
      newnode^.links := baum(nl, elements[1..nl]);
      newnode^.rechts := baum(nr, elements[nl+1..nl+1+nr]);
      baum := newnode;
    End
End;

(*
* 	Die Loesung. 
*)
procedure spiegeln(inRefWurzel: tRefKnoten);
{ Spiegelt unseren Baum. }
var
	refHilfsBaum : tRefKnoten;
begin
	if inRefWurzel <> nil then
	begin
		spiegeln(inRefWurzel^.rechts);
		spiegeln(inRefWurzel^.links);
		
		
		refHilfsBaum := inRefWurzel^.links;
		inRefWurzel^.links := inRefWurzel^.rechts;
		inRefWurzel^.rechts := refHilfsBaum;
	end;
end;

(* Hauptprogramm *)
begin

	(* Wurzel und Baum aufbauen initialisieren *)
	root := baum(ANZAHL_KNOTEN, KEYS);   
	
	(* Ausgabe des Baums *)
	writeln('Baum:');
	druckeBaum(root, 0); 
	writeln('Baum (gespiegelt):');
	spiegeln(root);
	druckeBaum(root, 0);
  
end.
