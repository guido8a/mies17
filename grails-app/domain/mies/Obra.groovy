package mies

class Obra implements Serializable {
    Unidad unidad
    CodigoComprasPublicas codigoComprasPublicas
    TipoCompra tipoCompra
    Asignacion asignacion
    Obra obra
    ModificacionProyecto modificacionProyecto
    String descripcion
    double cantidad
    double costo
    String cuatrimestre1
    String cuatrimestre2
    String cuatrimestre3
    double ejecucion
    String estado
    Date fechaInicio
    Date fechaFin
    String observaciones
    String certificado    /* S--> si    N--> no*/
    Date fechaCertificado
    static auditable=[ignore:[]]
    static mapping = {
        table 'obra'
        cache usage:'read-write', include:'non-lazy'
        id column:'obra__id'
        id generator:'identity'
        version false
        columns {
            id column:'obra__id'
            unidad column: 'undd__id'
            codigoComprasPublicas column: 'cpac__id'
            tipoCompra column: 'tpcp__id'
            asignacion column: 'asgn__id'
            obra column: 'obrapdre'
            modificacionProyecto column: 'mdfc__id'
            descripcion column: 'obradscr'
            cantidad column: 'obracntd'
            costo column: 'obracsto'
            cuatrimestre1 column: 'obractr1'
            cuatrimestre2 column: 'obractr2'
            cuatrimestre3 column: 'obractr3'
            ejecucion column: 'obraejec'
            estado column: 'obraetdo'
            fechaInicio column: 'obrafcin'
            fechaFin column: 'obrafcfn'
            observaciones column: 'obraobsr'
            certificado column: 'obracrtf'
            fechaCertificado column:'obrafccr'
        }
    }
    static constraints = {
        unidad( blank:true, nullable:true ,attributes:[mensaje:'Unidad de medida'])
        codigoComprasPublicas( blank:true, nullable:true ,attributes:[mensaje:'Código de Compras Públicas'])
        tipoCompra( blank:true, nullable:true ,attributes:[mensaje:'Tipo de Compra'])
        asignacion( blank:true, nullable:true ,attributes:[mensaje:'Asignación presupuestaria a la actividad'])
        obra( blank:true, nullable:true ,attributes:[mensaje:'Registro original de la obra'])
        modificacionProyecto( blank:true, nullable:true ,attributes:[mensaje:'Documento de modificación con el que se modifica o crea un nuevo registro'])
        descripcion(size:1..255, blank:true, nullable:true ,attributes:[mensaje:'Descripción del producto, bien o servicio a adquirir'])
        cantidad( blank:true, nullable:true ,attributes:[mensaje:'Cantidad'])
        costo( blank:true, nullable:true ,attributes:[mensaje:'Costo unitario'])
        cuatrimestre1(size:1..1, blank:true, nullable:true ,attributes:[mensaje:'A ejecutarse en el cuatrimestre 1 S/N'])
        cuatrimestre2(size:1..1, blank:true, nullable:true ,attributes:[mensaje:'A ejecutarse en el cuatrimestre 2 S/N'])
        cuatrimestre3(size:1..1, blank:true, nullable:true ,attributes:[mensaje:'A ejecutarse en el cuatrimestre 3 S/N'])
        ejecucion( blank:true, nullable:true ,attributes:[mensaje:'Ejecución'])
        estado(size:1..1, blank:true, nullable:true ,attributes:[mensaje:'Estado'])
        fechaInicio( blank:true, nullable:true ,attributes:[mensaje:'Fecha de Inicio'])
        fechaFin( blank:true, nullable:true ,attributes:[mensaje:'Fecha de Fin'])
        observaciones(size:1..127, blank:true, nullable:true ,attributes:[mensaje:'Observaciones'])
        certificado(size: 1..1,nullable: true,blank: true)
        fechaCertificado(blank: true, nullable: true)
    }
}