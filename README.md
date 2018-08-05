# Cheatsheet Pascal

## Syntax

### Grundlegender Programmaufbau

```pascal
program name(input, ouput)

const
     ...
type
     ...
var
     ...
begin
 
 { Statements }
 (* weitere Statements *)
 // Ein Kommentar
 
end.
```
### Typen

### Prozeduren / Funktionen

### Schleifen

#### while

```pascal
while (expr) do
begin 
 (* statements *)
end;
```

### Bedingungen

# Muster

## Durch eine Liste iterieren (laufen)

```pascal
type
    tRefDVElement = ^tDVElement
    tDVElement = record
        Wert: integer;
        next, prev: tRefDVElement;
    end;

procedure DurchlaufeListe(inRefListe: tRefDVElement);
var
    (* Hilfszeiger zum Iterieren *)
    z : tRefDVElement;
begin 
     z := inRefListe;
     while (z <> nil) do
     begin
        (* statements *)
        z := z^.next;
     end;
end;
```
## Suchen in Listen

```pascal
function SucheInListe(inRefListe: tRefDVElement, inSuchwert: integer) : tRefDVElement;
var
    (* Hilfszeiger zum Iterieren *)
    z : tRefDVElement;
    gefunden : boolean;
begin 
     z := inRefListe;
     gefunden := false;
     while (z <> nil) and (gefunden = false) do
     begin
        
        if z.Wert = inSuchwert then
            gefunden := true
        else
            (* nachstes Element betrachten *) 
            z := z^.next;
     end;

     SucheInListe := z;
end;
```

## Element zur Liste hinzufügen

```pascal
function push(inRefListe: tRefDVElement, inWert: integer) : tRefDVElement;
var
    e : tRefDVElement;
begin

    new(e);
    e^.next := nil;
    e^.Wert := inWert;

    if inRefList <> nil then
        inRefListe^.next := e;

    push := e;

end;
```

## Element in eine Liste einfügen

```pascal
function insert(inRefListe: tRefDVElement, inWert: integer) : tRefDVElement;
var
    e : tRefDVElement;
begin

    new(e);
    e^.Wert := inWert;
    e^.next := nil;

    if inRefList <> nil then
    begin
        e^.next := inRefListe^.next;
        inRefListe^.next := e;
    end;
    insert := e;

end;
```

## Rekursiver Abstieg

```pascal
type
    tRefBinBaum = ^tBinBaum;
    tBinBaum = record
            Wert: integer;
            links, rechts: tRefBinBaum;
        end;

function Abstieg(inRefWurzel: tRefBinBaum): boolean;
var
    ergebnis : boolean;
begin
    ergebnis := false;
    if inRefWurzel <> nil then
    begin

        (* Variante 1 *)
        Abstieg(inRefWurzel^.links);
        Abstieg(inRefWurzel^.rechts);

        (* Variante 2 *)
        ergebnis := Abstieg(inRefWurzel^.links) and Abstieg(inRefWurzel^.rechts);

        (* Variante 3 *)
        if ( .. ) then
            ergebnis := Abstieg(inRefWurzel^.links)
        else
            ergebnis := Abstieg(inRefWurzel^.rechts)
        

    end;
    Abstieg := ergebnis;
end;

```