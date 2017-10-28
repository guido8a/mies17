package mies

class Canton implements Serializable {
    Provincia provincia
    Zona zona
    Integer numero
    String nombre
    static auditable=[ignore:[]]
    static mapping = {
        table 'cntn'
        cache usage:'read-write', include:'non-lazy'
        id column:'cntn__id'
        id generator:'identity'
        version false
        columns {
            id column:'cntn__id'
            zona column: 'zona__id'
            provincia column: 'prov__id'
            numero column: 'cntnnmro'
            nombre column: 'cntnnmbr'
        }
    }
    static constraints = {
        zona(blank:true, nullable:true ,attributes:[mensaje:'Zona a la que pertenece el cantón'])
        provincia(blank:true, nullable:true ,attributes:[mensaje:'Provincia a la que pertenece el cantón'])
        numero( blank:true, nullable:true ,attributes:[mensaje:'Número del cantón'])
        nombre(size:1..63, blank:true, nullable:true ,attributes:[mensaje:'Nombre del cantón'])
    }
    String toString() {
        return this.nombre
    }
}