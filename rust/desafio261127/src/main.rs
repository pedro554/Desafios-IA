fn maior_sequencia_de_alta(temperaturas: &[i32]) -> usize {
    if temperaturas.is_empty() || temperaturas.len() > 100000 {
        return 0;
    }

    let mut maior_seq: Vec<i32> = Vec::new();
    let mut seq: Vec<i32> = Vec::new();
    let mut temp_anterior = -10000;

    for i in 0..temperaturas.len() {
        let temp_atual = temperaturas[i];

        if temp_atual > temp_anterior {
            seq.push(temp_atual);
            temp_anterior = temp_atual;
        } else {
            if seq.len() > maior_seq.len() {
                maior_seq.clear();
                for i in 0..seq.len() {
                    maior_seq.push(seq[i]);
                }
            }
            seq.clear();
            seq.push(temp_atual);
            temp_anterior = temp_atual;
        }
    }
    if seq.len() > maior_seq.len() {seq.len()} else {maior_seq.len()}
}

fn main() {
    let temperatura1 = [3, 5, 7, 2, 4, 6, 8];
    let temperatura2 = [1, 4, 2, 3, 5];
    let temperatura3 = [-3, -1, -1, 0];
    let temperatura4  = [];
    let temperatura5 = [8];
    let temperatura6 = [4, 4, 4];
    let temperatura7 = [9, 7, 5];
    let temperatura8 = [-2, 0, 3, 8];

    println!("{}", maior_sequencia_de_alta(&temperatura1));
    println!("{}", maior_sequencia_de_alta(&temperatura2));
    println!("{}", maior_sequencia_de_alta(&temperatura3));
    println!("{}", maior_sequencia_de_alta(&temperatura4));
    println!("{}", maior_sequencia_de_alta(&temperatura5));
    println!("{}", maior_sequencia_de_alta(&temperatura6));
    println!("{}", maior_sequencia_de_alta(&temperatura7));
    println!("{}", maior_sequencia_de_alta(&temperatura8));
}
