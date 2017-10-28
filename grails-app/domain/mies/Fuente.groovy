package mies

class Fuente implements Serializable {
    String descripcion
    String codigo
    static auditable=[ignore:[]]
    static mapping = {
        table 'fnte'
        cache usage:'read-write', include:'non-lazy'
        id column:'fnte__id'
        id generator:'identity'
        version false
        columns {
            id column:'fnte__id'
            codigo column: 'fntecdgo'
            descripcion column: 'fntedscr'
        }
    }
    static constraints = {
        codigo(size:1..3, blank:true, nullable:true ,attributes:[mensaje:'Descripción de la fuente de financiamiento del proyecto'])
        descripcion(size:1..63, blank:true, nullable:true ,attributes:[mensaje:'Descripción de la fuente de financiamiento del proyecto'])
    }

    String toString(){
        "${this.descripcion}"
    }
}