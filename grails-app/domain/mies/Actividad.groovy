package mies

class Actividad implements Serializable {
    String codigo
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'actv'
        cache usage:'read-write', include:'non-lazy'
        id column:'actv__id'
        id generator:'identity'
        version false
        columns {
            id column:'actv__id'
            codigo column: 'actvcdgo'
            descripcion column: 'actvdscr'
        }
    }
    static constraints = {
        codigo(size:1..20, blank:true, nullable:true ,attributes:[mensaje:'Código de la actividad'])
        descripcion(size:1..255, blank:true, nullable:true ,attributes:[mensaje:'Descripción corta de la actividad'])
    }
    String toString(){
        "${this.descripcion}"
    }
}