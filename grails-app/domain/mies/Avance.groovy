package mies

class Avance implements Serializable {
    Informe informe
    Meta meta
    String descripcion
    double valor
    static auditable=[ignore:[]]
    static mapping = {
        table 'avnc'
        cache usage:'read-write', include:'non-lazy'
        id column:'avnc__id'
        id generator:'identity'
        version false
        columns {
            id column:'avnc__id'
            informe column: 'info__id'
            meta column: 'meta__id'
            descripcion column: 'inditasa'
            valor column: 'avncvlor'
        }
    }
    static constraints = {
        informe( blank:true, nullable:true ,attributes:[mensaje:'Informe'])
        meta( blank:true, nullable:true ,attributes:[mensaje:'Meta'])
        descripcion(size:1..1023, blank:true, nullable:true ,attributes:[mensaje:'Descripción del avance realizado'])
        valor( blank:true, nullable:true ,attributes:[mensaje:'Valor avanzado respecto del indicador fijado para la meta'])
    }
}