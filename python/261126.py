def primeiro_unico(texto: str) -> int:
    tamanho_texto = len(texto)
    contagem = {}

    # string nao pode ser vazia ou ter mais que 100 mil caracteres
    if tamanho_texto <= 0 or tamanho_texto > 100000:
        return -1

    # se a string tem apenas 1 caracter retorna ele mesmo pois nao repete
    if tamanho_texto == 1:
        return 0

    for i in range(len(texto)):
        if contagem.get(texto[i]) != None:
            contagem[texto[i]] += 1
        else:
            contagem[texto[i]] = 0

    for key in contagem.keys():
        if contagem[key] == 0:
            return texto.find(key)

    return -1


print(primeiro_unico("leetcode"))
print(primeiro_unico("loveleetcode"))
print(primeiro_unico("aabb"))
print(primeiro_unico(""))
print(primeiro_unico("pedro"))
print(primeiro_unico("aabbc"))
