program Addiere(input, output);

const 
  (* unser Beispielbaum *)
  ANZAHL_KNOTEN = 7;
  KEYS: array [1..ANZAHL_KNOTEN] Of integer = (27,3,1,15,39,30,41);
  
type 
	(* Datenstrukturen aus der Aufgabe *)
	tRefBinBaum=^tBinBaum; 
	tBinBaum = record 
				Wert: Integer; 
				links,rechts:tRefBinBaum 
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
function AddiereBinBaum(inBaum: tRefBinBaum): integer; 
{Addiert die Werte aller Knoten des BBaumes inBaum.} 
begin 
	if inBaum = nil then 
		{Abbruchbedingung: Der Baum ist leer.} 
		AddiereBinBaum := 0 
	else 
	begin	
	{Rekursionsfall: Addition des Wertes mit den zwei Summen der Unterbäume.} 
		writeln(inBaum^.Wert);
		AddiereBinBaum :=   inBaum^.Wert +
			AddiereBinBaum(inBaum^.links) +
			AddiereBinBaum(inBaum^.rechts)
	end; 
end; 

function AddiereBinBaum2(inBaum: tRefBinBaum): integer; 
{Addiert die Werte aller Knoten des BBaumes inBaum.} 
var 
	erg : integer;
begin 
	if inBaum = nil then 
		{Abbruchbedingung: Der Baum ist leer.} 
		AddiereBinBaum2 := 0 
	else 
		{Rekursionsfall: Addition des Wertes mit den zwei Summen der Unterbäume.} 
	begin	
		erg := AddiereBinBaum2(inBaum^.links);
		erg := erg + inBaum^.Wert;
		writeln(inBaum^.Wert);
        erg := erg + AddiereBinBaum2(inBaum^.rechts);
        AddiereBinBaum2 := erg; 
	end; 
end; 

(* Hauptprogramm *)
begin

	(* Wurzel und Baum aufbauen initialisieren *)
	root := baum(ANZAHL_KNOTEN, KEYS);   
	
	(* Ausgabe des Baums *)
	writeln('Baum:');
	druckeBaum(root, 0);  
	writeln('Die Summe aller Knoten ist: ', AddiereBinBaum(root));
    writeln('Die Summe aller Knoten ist: ', AddiereBinBaum2(root));
    
end.
