package mies

class Unidad implements Serializable {
    String codigo
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'undd'
        cache usage:'read-write', include:'non-lazy'
        id column:'undd__id'
        id generator:'identity'
        version false
        columns {
            id column:'undd__id'
            codigo column: 'unddcdgo'
            descripcion column: 'undddscr'
        }
    }
    static constraints = {
        codigo(size:1..7, blank:true, nullable:true ,attributes:[mensaje:'Código de la unidad'])
        descripcion(size:1..63, blank:true, nullable:true ,attributes:[mensaje:'Descripción de la unidad'])
    }
    String toString(){
        "${this.descripcion}"
    }
}