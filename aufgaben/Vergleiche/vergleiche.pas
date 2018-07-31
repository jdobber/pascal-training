(*
* Schreiben Sie eine Funktion, die zwei Felder vom Typ tFeld als Eingabe bekommt und einen 
* boolean Wert zurückgibt, der anzeigt, ob alle Werte des ersten Feldes auch im zweiten Feld 
* enthalten sind. 
* Als Beispiele ergeben  
* die Eingaben [3,4,5,5,5] und [5,2,3,4,1] den Wert true, währenden  
* die Eingaben [1,2,3,3,1] und [1,2,4,4,5] den Wert false ergeben. 
*)
Program Vergleichen(input, output);

Const 
  MAX = 5;
  FELDGROESSE = MAX;
  MAXPLUS1 = MAX+1;
 
type
  tIndex = 1..MAX;
  tFeld = array[tIndex] of integer;
  tIndexMax = 1..MAXPLUS1;

var
  (* in FreePascal können Felder im Gegensatz zu Standard-Pascal
  * initialisert werden 
  * *)
  FeldA: tFeld = (1,2,3,4,5);
  FeldB: tFeld = (1,2,3,4,5);
  FeldC: tFeld = (7,2,3,4,5);
  FeldD: tFeld = (1,2,3,4,8);
  
  FeldE: tFeld = (3,4,5,5,5); (* Feld aus der Aufgabenstellung *)
  FeldF: tFeld = (5,2,3,4,1); (* Feld aus der Aufgabenstellung *)
  
  FeldG: tFeld = (1,2,3,3,1); (* Feld aus der Aufgabenstellung *)
  FeldH: tFeld = (1,2,4,4,5); (* Feld aus der Aufgabenstellung *)

  FeldI: tFeld = (1,2,3,4,4);
  FeldJ: tFeld = (1,2,3,3,4);

function vgl(inFeldA:tFeld;inFeldB:tFeld):boolean; 
{Die Funktion überprüft ob alle Werte des Feldes inFeldA auch im 
Feld inFeldB vorkommen.} 
  var 
   gefunden:boolean; 
   alleGefunden:boolean; 
   i:tIndex; 
   j:tIndex; 
  begin 
    alleGefunden:=true; 
      for i:=1 to FELDGROESSE do 
      begin 
        gefunden:=false; 
          for j:=1 to FELDGROESSE do 
            if (inFeldA[i]=inFeldB[j]) then 
              gefunden:=true; 
        if (gefunden=false) then 
           alleGefunden:=false 
      end; 
      vgl:=alleGefunden 
  end; 
    
function vgl2(inFeldA: tFeld; inFeldB: tFeld): boolean;
{ Variante 2 mit repeat-until Konstruktion }
var i, j: tIndexMax;
    gefunden: boolean;
begin
	i := 1;
	repeat
		gefunden := false;
		for j:=1 to MAX do
			if inFeldA[i] = inFeldB[j] then
				gefunden := true;
		if i <= MAX then
			i := i + 1;
	until (gefunden = false) or (i = MAXPLUS1);
	vgl2 := gefunden;
end;

function vgl3(inFeldA: tFeld; inFeldB: tFeld): boolean;
{ Variante 3 mit while Konstruktion }
var i, j: tIndexMax;
    gefunden: boolean;
begin
	i := 1;
	gefunden := true;
	while (gefunden = true) and (i < MAXPLUS1) do
	begin
		gefunden := false;
		for j:=1 to MAX do
			if inFeldA[i] = inFeldB[j] then
				gefunden := true;
		if i <= MAX then
			i := i + 1;
	end;
	vgl3 := gefunden;
end;

Begin 
   (* alle 3 Lösungen müssen die gleiche Lösung liefern *)
	writeln( vgl(FeldA, FeldB), ' ', vgl2(FeldA, FeldB), ' ', vgl3(FeldA, FeldB) );
	writeln( vgl(FeldA, FeldC), ' ', vgl2(FeldA, FeldC), ' ', vgl3(FeldA, FeldC) );
	writeln( vgl(FeldA, FeldD), ' ', vgl2(FeldA, FeldD), ' ', vgl3(FeldA, FeldD) );
	writeln( vgl(FeldE, FeldF), ' ', vgl2(FeldE, FeldF), ' ', vgl3(FeldE, FeldF) );
	writeln( vgl(FeldG, FeldH), ' ', vgl2(FeldG, FeldH), ' ', vgl3(FeldG, FeldH) );
	writeln( vgl(FeldI, FeldJ), ' ', vgl2(FeldI, FeldJ), ' ', vgl3(FeldI, FeldJ) );		
End.

