package mies

class TipoGasto implements Serializable {
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'tpgs'
        cache usage:'read-write', include:'non-lazy'
        id column:'tpgs__id'
        id generator:'identity'
        version false
        columns {
            id column:'tpgs__id'
            descripcion column: 'tpgsdscr'
        }
    }
    static constraints = {
        descripcion(size:1..15,blank:false,attributes:[mensaje:'Descripción del tipo de gasto'])
    }
    String toString(){
        "${this.descripcion}"
    }
}