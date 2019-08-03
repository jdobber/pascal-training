program Zeichen;

procedure ZeichenDrehen; 
{ liest eine Folge von Zeichen ein und gibt sie in umgekehrter Reihenfolge wieder aus }
var 
	Zeichen : char; 
begin 
	read (Zeichen); 
	if Zeichen = '.' then 
		{ Rekursionsabbruch } 
		writeln 
	else 
		begin { restliche Zeichen bearbeiten } 
		ZeichenDrehen; 
		{ nach Einlesen und Ausgeben der nachfolgenden Zeichen kann jetzt das Zeichen selbst ausgegeben werden }
		write (Zeichen) 
	end 
end; { ZeichenDrehen }

begin
	ZeichenDrehen();
end.
