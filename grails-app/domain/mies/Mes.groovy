package mies

class Mes implements Serializable {
    int numero
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'mess'
        cache usage:'read-write', include:'non-lazy'
        id column:'mess__id'
        id generator:'identity'
        version false
        columns {
            id column:'mess__id'
            numero column: 'messnmro'
            descripcion column: 'messdscr'
        }
    }
    static constraints = {
        numero( blank:true, nullable:true ,attributes:[mensaje:'Número del mes (1 para enero, 12 para diciembre)'])
        descripcion(size:1..15, blank:true, nullable:true ,attributes:[mensaje:'Nombre del mes'])
    }
    String toString(){
        "${this.descripcion}"
    }

}