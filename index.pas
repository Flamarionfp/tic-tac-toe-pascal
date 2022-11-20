program tic_tac_toe;

uses crt;

var playerNames: array[1..2] of string;
var symbols: array[1..2] of string;
var currentPlayerIndex: integer;
var i, choosedPosition: integer;
var board: array[1..3, 1..3] of string;
var remainingPositions: array[1..9] of integer;
var hasWinner, isTie: boolean;
    
procedure sethasWinner();
begin
    hasWinner := true;
end;

procedure initBoard();
var i, j: integer;
begin
for i := 1 to 3 do
   begin
      for j := 1 to 3 do
      begin
         board[i, j] := '';
      end;
   end;
end;

procedure drawBoard();
begin
      clrscr; 
      writeln;
      writeln('  ', board[1, 1], ' | ', board[1, 2], ' | ', board[1, 3]);
      writeln(' -----------');
      writeln('  ', board[2, 1], ' | ', board[2, 2], ' | ', board[2, 3]);
      writeln(' -----------');
      writeln('  ', board[3, 1], ' | ', board[3, 2], ' | ', board[3, 3]);
      writeln;
end;

function validateSymbolChoice(symbol: string): boolean;
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

procedure changeCurrentPlayerIndex();
begin
    if currentPlayerIndex = 1 then
        currentPlayerIndex := 2
    else
        currentPlayerIndex := 1;
end;

procedure initRemainingPositions();
begin
    for i := 1 to 9 do
        remainingPositions[i] := i;
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

procedure showInstructionMessage();
var i: integer;
begin
    if(currentPlayerIndex = 1) then
        textcolor(9)
    else 
        textcolor(14);
    writeln(playerNames[currentPlayerIndex], ', escolha uma posicao para marcar com o simbolo ', symbols[currentPlayerIndex]);
    textcolor(11);
    write('Posicoes disponiveis: ');
    for i := 1 to 9 do
    begin
        if remainingPositions[i] <> 0 then
            write(remainingPositions[i], ' ');
    end;
        textcolor(15);
end;

procedure applyPlayerChoice();
var i, j, k: integer;
begin
    k := 1;
    for i := 1 to 3 do
    begin
        for j := 1 to 3 do
        begin
           if choosedPosition = k then
              begin
                board[i, j] := symbols[currentPlayerIndex];
                remainingPositions[k] := 0;
              end;
            k := k + 1;
        end;
    end;
end;

procedure verifyGameOver();
var i: integer;
begin
    for i := 1 to 9 do
    begin
        if remainingPositions[i] <> 0 then
            exit;
    end;
    isTie := true;
end;
    
begin
    hasWinner := false;
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

    textcolor(14);
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
    initRemainingPositions();
    initBoard();
    drawBoard();
    currentPlayerIndex := randomFirstPlayerIndex();
    repeat
        showInstructionMessage();
        readln(choosedPosition);
        while (choosedPosition < 1) or (choosedPosition > 9) do 
        begin
            showErrorMessage('Posicao invalida. Digite novamente: ');
            textcolor(15);
            readln(choosedPosition);
        end;
        while remainingPositions[choosedPosition] = 0 do
            begin
                showErrorMessage('Posicao ja utilizada. Digite novamente: ');
                textcolor(15);
                readln(choosedPosition);
            end;
        applyPlayerChoice();
        drawBoard();
        changeCurrentPlayerIndex();
        verifyGameOver();
    until (hasWinner) or (isTie);

    if hasWinner then
    begin
        textcolor(2);
        writeln(playerNames[currentPlayerIndex], ' venceu!');
    end
    else
    begin
        textcolor(2);
        writeln('Empate!');
    end;
end.