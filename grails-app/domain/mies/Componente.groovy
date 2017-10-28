package mies

class Componente {
    
    String descripcion

    static auditable=[ignore:[]]
    static mapping = {
        table 'comp'
        cache usage:'read-write', include:'non-lazy'
        id column:'comp__id'
        id generator:'identity'
        version false
        columns {
            id column:'comp__id'
            descripcion column: 'compdscr'
        }
    }
    static constraints = {
        descripcion(nullable: false,blank: false,size: 1..1024)
    }

    String toString(){
        "${this.descripcion}"
    }
}
