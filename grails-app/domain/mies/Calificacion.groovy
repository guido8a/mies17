package mies

class Calificacion implements Serializable {
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'calf'
        cache usage:'read-write', include:'non-lazy'
        id column:'calf__id'
        id generator:'identity'
        version false
        columns {
            id column:'calf__id'
            descripcion column: 'calfdscr'
        }
    }
    static constraints = {
        descripcion(size:1..15,blank:false,attributes:[mensaje:'Descripción de la calificación'])
    }
    String toString(){
        "${this.descripcion}"
    }
}