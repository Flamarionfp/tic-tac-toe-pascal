program tic_tac_toe;

uses crt;

var playerNames: array[1..2] of string;
var symbols: array[1..2] of char;
var currentPlayerIndex: integer;
var i: integer;

function validateSymbolChoice(symbol: char): boolean;
begin
    if (symbol = 'X') or (symbol = 'O') then
        validateSymbolChoice := true
    else
        validateSymbolChoice := false;
end;

function validateUsername(name: string): boolean;
begin
    if (playerNames[1] = playerNames[2]) then
        validateUsername := false
    else
        validateUsername := true;
end;

function getRemainingSymbol(): char;
begin
    if symbols[1] = 'X' then
        getRemainingSymbol := 'O'
    else
        getRemainingSymbol := 'X';
end;

function randomFirstPlayerIndex(): integer;
begin
  randomize;
  randomFirstPlayerIndex := random(2) + 1;
end;

procedure showErrorMessage(message: string);
begin
   textcolor(4);
   writeln(message);
end;
    
begin
    clrScr;
    textcolor(11);
    writeln('--------Jogo da velha--------');
    textcolor(9);
    writeln('Jogador 1, digite seu nome: ');
    textcolor(15);
    readln(playerNames[1]);
    textcolor(15);
    writeln('Qual o seu simbolo? (X ou O): ');
    readln(symbols[1]);
    while not validateSymbolChoice(symbols[1]) do
    begin
        showErrorMessage('Simbolo invalido. Digite X ou O: ');
        textcolor(15);
        readln(symbols[1]);
    end;

    textcolor(9);
    writeln('Jogador 2, digite seu nome: ');
    textcolor(15);
    readln(playerNames[2]);
    while not validateUsername(playerNames[2]) do
      begin
        showErrorMessage('Nome ja utilizado. Digite novamente seu nome: ');
        textcolor(15);
        readln(playerNames[2]);
      end;
       

    textcolor(15);
    symbols[2] := getRemainingSymbol();

    textcolor(2);
    for i := 1 to 2 do
      writeln('Jogador ', i, ': ' , playerNames[i] , ' - Simbolo: ', symbols[i]);
    
    textcolor(15);
    writeln('Aperte enter para continuar...');
    // writeln(randomFirstPlayerIndex());
    readln();
end.