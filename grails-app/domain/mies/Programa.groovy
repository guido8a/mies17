package mies

class Programa implements Serializable {
    String codigo
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'prgr'
        cache usage:'read-write', include:'non-lazy'
        id column:'prgr__id'
        id generator:'identity'
        version false
        columns {
            id column:'prgr__id'
            codigo column: 'prgrcdgo'
            descripcion column: 'prgrdscr'
        }
    }
    static constraints = {
        codigo(size:1..2, blank:true, nullable:true ,attributes:[mensaje:'Código según el ESIGEF'])
        descripcion(size:1..1023,blank:false,attributes:[mensaje:'Descripción del programa'])
    }
    String toString(){
        "${this.descripcion}"
    }
}