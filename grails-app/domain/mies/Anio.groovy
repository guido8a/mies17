package mies

class Anio implements Serializable {
    String anio
    int estado =0 /* 0 -> no aprobado    1-> aprobadp */
    static auditable=[ignore:[]]
    static mapping = {
        table 'anio'
        cache usage:'read-write', include:'non-lazy'
        id column:'anio__id'
        id generator:'identity'
        version false
        columns {
            id column:'anio__id'
            anio column: 'anioanio'
            estado column: 'anioetdo'
        }
    }
    static constraints = {
        anio(size:1..31,blank:false,attributes:[mensaje:'Año al cual corresponde el PAPP'])
        estado(blank: false, nullable: false)
    }

    String toString(){
        "${this.anio}"
    }
}