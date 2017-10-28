package mies

class Sigef {
    Anio anio
    Mes mes
    Date fecha
    String archivo

    static auditable=[ignore:[]]
    static mapping = {
        table 'sigf'
        cache usage:'read-write', include:'non-lazy'
        id column:'sigf__id'
        id generator:'identity'
        version false
        columns {
            anio column:    'anio__id'
            mes column:     'mess__id'
            fecha column:   'sigffcha'
            archivo column: 'sigfarch'
        }
    }
    static constraints = {
        anio(nullable: false,blank: false)
        mes(nullable: false,blank: false)
        fecha( blank:true, nullable:true ,attributes:[mensaje:'Fecha de carga de datos'])
    }
}
