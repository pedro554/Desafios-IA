def esta_balanceada(texto: str) -> bool:
    abertos = 0

    for caractere in texto:
        if caractere == '(':
            abertos += 1
        elif caractere == ')':
            abertos -= 1

            if abertos < 0:
                return False
        else:
            return False

    return abertos == 0


print(esta_balanceada('()'))  # true
print(esta_balanceada('(()())'))  # true
print(esta_balanceada('())('))  # false
print(esta_balanceada(''))  # true - Ok
print(esta_balanceada('()()())(()()'))  # false
print(esta_balanceada(')()'))  # false
print(esta_balanceada('())'))  # false
print(esta_balanceada('()()()()()()()()()'))  # true
