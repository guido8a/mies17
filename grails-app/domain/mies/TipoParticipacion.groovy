package mies

class TipoParticipacion implements Serializable {
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'tppt'
        cache usage:'read-write', include:'non-lazy'
        id column:'tppt__id'
        id generator:'identity'
        version false
        columns {
            id column:'tppt__id'
            descripcion column: 'tpptdscr'
        }
    }
    static constraints = {
        descripcion(size:1..31,blank:false,attributes:[mensaje:'Descripción del tipo de participación'])
    }
    String toString(){
        "${this.descripcion}"
    }
}