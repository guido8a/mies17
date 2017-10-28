package mies

class TipoCompra implements Serializable {
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'tpcp'
        cache usage:'read-write', include:'non-lazy'
        id column:'tpcp__id'
        id generator:'identity'
        version false
        columns {
            id column:'tpcp__id'
            descripcion column: 'tpcpdscr'
        }
    }
    static constraints = {
        descripcion(size:1..63, blank:true, nullable:true ,attributes:[mensaje:'Descripción del tipo de compra'])
    }
    String toString(){
        "${this.descripcion}"
    }
}