{$B+}
program KommtVor(input, output);

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
function kommtVor(inRefWurzel: tRefKnoten; inSuchwert: integer): boolean;
{ Rückgabe ist true genau dann wenn der Suchbaum mit Wurzel inWurzel 
* einen Knoten mit info inSuchwert enthält. }

begin
	if inRefWurzel <> nil then
	begin
	    writeln(inRefWurzel^.info);
		if inRefWurzel^.info = inSuchwert then kommtVor := true
		else
			kommtVor:= kommtVor(inRefWurzel^.links, inSuchwert) or
					   kommtVor(inRefWurzel^.rechts, inSuchwert);	
	end
	else kommtVor := false;		
		
end;

(* Hauptprogramm *)
begin

	(* Wurzel und Baum aufbauen initialisieren *)
	root := baum(ANZAHL_KNOTEN, KEYS);   
	
	(* Ausgabe des Baums *)
	writeln('Baum:');
	druckeBaum(root, 0);  
	writeln('Kommt die 1 im Baum vor? :', kommtVor(root, 1));
    writeln('Kommt die 27 im Baum vor? :', kommtVor(root, 27));
	writeln('Kommt die 41 im Baum vor? :', kommtVor(root, 41));
    writeln('Kommt die 16 im Baum vor? :', kommtVor(root, 16));
  
end.
