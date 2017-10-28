package mies

class Presupuesto implements Serializable {
    Presupuesto presupuesto
    String numero
    String descripcion
    int nivel
    int movimiento = 0
    static auditable=[ignore:[]]
    static mapping = {
        table 'prsp'
        cache usage:'read-write', include:'non-lazy'
        id column:'prsp__id'
        id generator:'identity'
        version false
        columns {
            id column:'prsp__id'
            presupuesto column: 'prsppdre'
            numero column: 'prspnmro'
            descripcion column: 'prspdscr'
            nivel column: 'prspnvel'
            movimiento column: 'prspmvnt'
        }
    }
    static constraints = {
        presupuesto( blank:true, nullable:true ,attributes:[mensaje:'Partida padre'])
        numero(size:1..15, blank:true, nullable:true ,attributes:[mensaje:'Número de la partida'])
        descripcion(size:1..255, blank:true, nullable:true ,attributes:[mensaje:'Descripción de la aprtida'])
        nivel( blank:true, nullable:true ,attributes:[mensaje:'Nivel de la partida'])
        movimiento(blank: true,nullable: true)
    }
    String toString(){
        "${this.numero}(${this.descripcion})"
    }
}