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
procedure DurchlaufeListe( inListe: tRefListenElement )
var
     z : tRefListenElement
begin 
     z := inListe;
     while (z <> nil) do
     begin
          (* statements *)
          
          z := z.^next;
     end;
end;
```


