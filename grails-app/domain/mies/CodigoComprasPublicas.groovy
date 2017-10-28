package mies

class CodigoComprasPublicas implements Serializable {
    CodigoComprasPublicas padre
    String numero
    String descripcion
    String nivel
    int movimiento = 0
    Date fecha
    static auditable=[ignore:[]]
    static mapping = {
        table 'cpac'
        cache usage:'read-write', include:'non-lazy'
        id column:'cpac__id'
        id generator:'identity'
        version false
        columns {
            id column:'cpac__id'
            padre column: 'cpacpdre'
            numero column: 'cpacnmro'
            descripcion column: 'cpacdscr'
            nivel column: 'cpacnvel'
            fecha column: 'cpacfcha'
            movimiento column: 'cpacmvnt'
        }
    }
    static constraints = {
        padre( blank:true, nullable:true ,attributes:[mensaje:'Cuenta padre'])
        numero(size:1..15, blank:true, nullable:true ,attributes:[mensaje:'Número de la cuenta'])
        descripcion(size:1..255, blank:true, nullable:true ,attributes:[mensaje:'Descripción de la cuenta'])
        nivel( blank:true, nullable:true ,attributes:[mensaje:'Nivel'])
        fecha( blank:true, nullable:true ,attributes:[mensaje:'Fecha de creación'])
        movimiento(nullable: false,blank: true)
    }
    
    String toString(){
        return "${this.numero}"
    }
}