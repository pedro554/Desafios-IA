program Resolucao;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Generics.Collections,
  System.Math,
  System.Generics.Defaults;

type
  TEnvio = record
    IdAtendimento: Cardinal;
    IdEnvio: Cardinal;
    ValorCentavos: Int64;
    class function Criar(AIdAtendimento: Cardinal; AIdEnvio: Cardinal; AValorCentavos: Int64): TEnvio; static;
  end;

  TTotalAtendimento = record
    IdAtendimento: Cardinal;
    TotalCentavos: Int64;
    class function Criar(AIdAtendimento: Cardinal; ATotalCentavos: Int64): TTotalAtendimento; static;
  end;

  TChave = record
    idAtendimento: Cardinal;
    idEnvio: Cardinal;
  end;

function TotaisPorAtendimento(const Envios: TArray<TEnvio>): TArray<TTotalAtendimento>;
var
  RegistroProcessado: TDictionary<TChave, TEnvio>;
  Totais: TDictionary<Cardinal, Int64>;
  Chave: TChave;
begin
  // inicia com array vazio
  Result := [];

  // cria um dicionario para gravar os registros processados
  RegistroProcessado := TDictionary<TChave, TEnvio>.Create;
  Totais := TDictionary<Cardinal, Int64>.Create;
  try
    // Até 100.000 linhas
    if Length(Envios) > 100000 then
      Exit;

    // Entrada vazia deve retornar lista vazia
    if Length(Envios) <= 0 then
      Exit(Result);

    for var I := Low(Envios) to High(Envios) do
    begin
      Chave.idAtendimento := Envios[I].IdAtendimento;
      Chave.idEnvio := Envios[I].IdEnvio;
        
      // verifica se o registo ja foi processado, se ja, ignora
      if RegistroProcessado.ContainsKey(Chave) then
        Continue
      else
        RegistroProcessado.Add(Chave, Envios[I]);

      if not Totais.ContainsKey(Chave.idAtendimento) then
        Totais.Add(Chave.idAtendimento, 0);

      var Total: Int64 := 0;

      if Totais.TryGetValue(Chave.idAtendimento, Total) then
      begin
        Total := Total + Envios[I].ValorCentavos;
        Totais.AddOrSetValue(Chave.idAtendimento, Total);
      end;
    end;

    for var Key: Cardinal in Totais.Keys do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := TTotalAtendimento.Criar(Key, Totais[Key]);
    end;

    TArray.Sort<TTotalAtendimento>(
      Result,
      TComparer<TTotalAtendimento>.Construct(
      function(const A, B: TTotalAtendimento): Integer
      begin
        Result := CompareValue(A.IdAtendimento, B.IdAtendimento);
      end)
    );
  finally
    RegistroProcessado.Free;
    Totais.Free;
  end;
end;

{ TEnvio }

class function TEnvio.Criar(AIdAtendimento: Cardinal; AIdEnvio: Cardinal; AValorCentavos: Int64): TEnvio;
begin
  Result.IdAtendimento := AIdAtendimento;
  Result.IdEnvio := AIdEnvio;
  Result.ValorCentavos := AValorCentavos;
end;

{ TTotalAtendimento }

class function TTotalAtendimento.Criar(AIdAtendimento: Cardinal; ATotalCentavos: Int64): TTotalAtendimento;
begin
  Result.IdAtendimento := AIdAtendimento;
  Result.TotalCentavos := ATotalCentavos;
end;

begin
  try
    var Val: TArray<TEnvio> := [
        TEnvio.Criar(9, 502, 450),
        TEnvio.Criar(7, 501, 1200),
        TEnvio.Criar(7, 501, 1200),
        TEnvio.Criar(7, 503, 350),
        TEnvio.Criar(9, 504, 450)
      ];

    var Atendimentos: TArray<TTotalAtendimento> := TotaisPorAtendimento(Val);

    for var I := Low(Atendimentos) to High(Atendimentos) do
    begin
      Writeln(Atendimentos[I].IdAtendimento);
      Writeln(Atendimentos[I].TotalCentavos);
    end;

    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.


