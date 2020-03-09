CREATE OR REPLACE PACKAGE pkg_Epm_WebCoupon
IS
/******************************************************************************
    <Package Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>pkg_Epm_WebCoupon</Unidad>
    <Autor>Luis Fernando Cruz ( lcruzp ) Trebol Software S.A</Autor>
    <Fecha>20-Ago-2009</Fecha>
    <Descripcion>
    Package que contiene el API para obtener los datos asociados al cupon de pago
    de la suscripcion.
    </Descripcion>
    <Historial>
        <Modificacion Autor="DHURTADP" Fecha="06-02-2020" Inc="WO0000000478243">
            * Se modifican los cursores y funciones para optimizar sentencias y procesos:
                - cuCupon
                - cuUltFactura
                - cuUltFacturaAnt
                - cuUltCupon
                - cuUltCupcc
                - cuCuponSolEst                
                - cuConsFactPer
                - cuUniMedConsFactPer
                - fnuObtValFactura
                - cuProdCont
                - GetDataCupon
                
            * Se crean las constantes csbEPM_PROG_FACT_PAGO_LINEA, csbEPM_CUPOPROG_EXCLWEB, csbEPM_TIPOCUPO_EXCLWEB.
            * Se elimina la cosntante csbFormatoFecha por desuso.
        </Modificacion>
        <Modificacion Autor="VJIMENEC" Fecha="04-02-2020" Inc="WO0000000456709">
            * Se crea un nuevo metodo fnuValorCuponAnticipado el cual obtiene el valor de un cupón de pago anticipado tipo FA bajo ciertas condiciones.            
            * Se Modifican las lineas donde se obtiene el saldo de la factura por el llamado al nuevo metodo.            
        </Modificacion>    
            
        <Modificacion Autor="VJIMENEC" Fecha="06-05-2019" Inc="WO0000000143802">
            * Se modifica el método Validate_Cupon con el fin de incluir en las validaciones el tipo de cupón PP.
            * Se crea un nuevo método ValidateCuponPP, el cual sirve para valiadar y consultar la información del cupón tipo PP.
            * Se modifica el método GetDataOut, con el fin de incluir en el proceso, el cupón tipo PP.
            * Se modifica el método ValidaConsulta, con el fin de incluir en el proceso de validación para obtener datos el cupón tipo PP.
            * Se modifica el método GetDataCupon, con el fin de incluir en el retorno de información el cupón tipo PP
        </Modificacion>
        
		<Modificacion Autor="VJIMENEC" Fecha="14-12-2018" Inc="OC835020">
            * Se realizar Ajuste en GetCupones con el fin de que se permita visualizar los cupones para pago de las facturas pendientes de pago del último periodo vigente de facturación,
            antes del ajuste solo se visualizan los cupones de la última factura del último periodo de facturación.
        </Modificacion>
        
        <Modificacion Autor="VJIMENEC" Fecha="04-12-2018" Inc="OC830725">
            * Se crea nueva funcion fnuObtValFactura que Obtiene el Valor Total de la Factura - Valor de Notas Generadas por Concepto de Anulación de Pagos.
            Se Modifica procedimiento Consultar, en la consulta que obtiene el historial de las facturas para obtener el valor total de la misma, invocando la nueva funcion.
        </Modificacion>
         
        <Modificacion Autor="truizdia" Fecha="04-12-2018" Inc="OC830787">
        * Se crea el método GetExcedentesEnergia que devuelve un cursor referenciado con el detalle por hora de 
          los excedentes de energía para la implementación de la CREG030.
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="17-10-2018" Inc="OC820435">
        * Se modifican las consultas de factura para que retornen las facturas de los programas dados por
          el parametro EPM_PROG_FACT_PAGO_LINEA
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="22-08-2018" Inc="OC806504">
        * Se modifican las consultas de cupon para que retornen multiregistro validando para los cupones de facturas
          trimestrales el recaudo de cupon. Adicionalmente debe retornar todos los cupones disponibles para pago
          incluyendo los de facturas intermedias y los cupones de negociacion.
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="05-09-2018" Inc="OC810468">
        * Se ajusta la consulta del metodo GetLatestInvoices ultimas facturas para que obtenga el cupon padre
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="01-08-2018" Inc="OC802329">
        * Se modifican las consultas de ultima factura para quitar el join innecesario con suscripc
        </Modificacion>
    
        <Modificacion Autor="lcruzp" Fecha="02-05-2018" Inc="OC780041">
        * Se modifican los metodos y las consultas para parametrizar los tipos de cupon
          excluidos para el proceso. Parametro EPM_TIPOCUPO_EXCLWEB 'AD, FI, NG'
        </Modificacion>
    
        <Modificacion Autor="jpinedc" Fecha="20-04-2018" Inc="OC772259V4">
        Se modifica en Validate_Suscr el cursor referenciado de salida para 
        1.- que el cupón padre se retorne sin los digitos de chequeo para
        realizar la busqueda de los cupones hijos
        2.- que a los cupones hijos(fracciones) se  agregan los digitos de chequeo 
        3.- que al cupón padre se  agregan los digitos de chequeo
        realizar la busqueda                       
        </Modificacion>
    
        <Modificacion Autor="jpinedc" Fecha="19-04-2018" Inc="OC772259V3">
        Se modifica en Validate_Suscr
        1.- el cursor cuUltCupon que obtiene el último cupón debido a que para
        bimestrales y trimestrales (solo de energia postpago) no se retornan
        todos los cupones de fracciones mensuales y total porque las fracciones
        son iguales en valor
        2.- el cursor referenciado de salida
        </Modificacion>

        <Modificacion Autor="jpinedc" Fecha="17-04-2018" Inc="OC772259V2">
        Se modifican los cursores para corregir la manera
        como se obtiene la última factura
        *   CURSOR cuFactura: se agrega factfege
        *   CURSOR cuUltFactura: se agrega cursor para obtener facturas de cupones
            tipo Cuenta de Cobo
        </Modificacion>

        <Modificacion Autor="jpinedc" Fecha="09-04-2018" Inc="OC772259">
        Se modifica los siguientes métodos y cursores para corregir la manera
        como se obtiene el último cupón
        *   GetDataCupon
        *   CURSOR cuUltCupon
        *   CURSOR cuUltCupcc
        </Modificacion>    

        <Modificacion Autor="rolartep" Fecha="02-02-2016" Inc="OC555415">
        Se modifica el método pkg_Epm_WebCoupon.GetCupones, para permitir retornar en el cursor referenciado,
        la información correspondiente a cuentas vencidas del contrato asociado a la factura, así como tambien
        la fecha de la factura del cupó y permitir adicionalmente que los datos salgan ordenados descendentemente 
        por el número de cuentas vencidas
        </Modificacion>
    
        <Modificacion Autor="rolartep" Fecha="27-01-2016" Inc="OC554300">
        * Se adiciona el metodo pGetServicesByAddress para consultar el detalle de grupo de servicio 
          por contratos de una dirección.
        </Modificacion>

        <Modificacion Autor="jhernasi" Fecha="28-09-2015" Inc="OC522953">
        * Se adiciona el metodo pGetInvoiceDetail para consultar el detalle por grupo de servicio de una factura.
        * Se adiciona el metodo InitializeDetCursor para inicializar el cursor referenciado usado en la consulta de grupos
          de servicio por factura
        </Modificacion>

      <Modificacion Autor="jpinedc" Fecha="24-03-2015" Inc="OC467849">
          Se modifica en el metodo GetLatestInvoices el cursor referenciado incluyendo
          el programa EPMPFM
      </Modificacion>      
    
        <Modificacion Autor="aperaltd" Fecha="20-02/2015" Inc="OC458660">
        Se modifica el metodo GetLatestInvoices quitandole la condicion AND factprog = 'FGCC'
        para tener encuenta las facturas generadas por otros programas
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="13-01-2015" Inc="OC446796_26">
        * Se adiciona el metodo GetLatestInvoices para consultar las ultimas (n) facturas
          de un contrato.
        * Se modifican todos los cursores de consultas de cupones para excluir los cupones de negociacion NG y tambien
          los cupones generados por los programas definidos en el parametro EPM_CUPOPROG_EXCLWEB.
        </Modificacion>

        <Modificacion Autor="rolartep" Fecha="25-Ago-2014" Inc="OC392747_23">
        - Se modifica el método Validate_Cupon para eliminar la lógica de pagos.
        - Se modifica el método ValidaConsulta para eliminar la lógica de pagos
        - Se elimina el parámetro de salida onuPagoVapa debido a que el mismo, ya no es requerido para los procesos de validación.

        - Se elimina el parámetro de salida onuPagoVapa, en los siguientes métodos:
            Validate_Cupon
            ValidaConsulta
            Validate_Suscr
            Validate_Cuenta
            GetDataOut
            
        - Se modifica el método GetCupones que inicializa en null el cursor de salida; para adicionar al final una nueva columna (NUMBER - SaldoPendiente)
        - Se modifica el tipo de registro tyrcDatos y el cursor orcRecordSet, para que se tenga en cuenta el valor del saldo pendiente
        </Modificacion>
    
        <Modificacion Autor="jpinedc" Fecha="31-Jul-2014" Inc="OC402523">
        * Se modifica GetCupones para que no procese contratos que lleguen nulos
        en la cadena de entrada isbContratos
        </Modificacion>

        <Modificacion Autor="jpinedc" Fecha="28-Jul-2014" Inc="OC402523">
        * Se crea el método pValidate_Periodos
         Verifica que la cantidad de periodos de facturación del ciclo del contrato que han transcurrido 
         desde el periodo de la factura no superen al dado por el parámetro EPM_PERVAL_WEBCUPON.
         Si lo superan se hace raise con el mensaje de error 16132
        * Se modifica ValidaConsulta:
            - Se modifica GetDataOut para ejecutarla con el nuevo parametro de salida onuPefaDocu
            - Se modifica para ejecutar pValidate_Periodos(ionuSuscCodi,onuPefaDocu)
        * Se modifica GetDataCupon para evaluar la ejecucion de ValidaConsult:
            - Si retorna error se devuelve un cursor nulo ( ejecutando el método openCursorNull)
            - Si no retorna error se evalua si se ejecta el método Consultar

        </Modificacion>            
        <Modificacion Autor="cdominn" Fecha="22-Ago-2012" Inc="OC238721">
         Se modifica el cursor cuUltFactura, eliminando el order by factpefa
         el cual causa un ordenamiento no deseado.
        </Modificacion>
        <Modificacion Autor="jpinedc" Fecha="26-Jul-2012" Inc="OC223155">
         Se modifica el metodo GetCupones para que incremente el contador de registros
         nuTotalDatos
         para los registros que tienen algun error en validación.         
        </Modificacion>
        <Modificacion Autor="jlondonr" Fecha="31-may-2012" Inc="OC223155">
         Se sobrecarga el método GetCupones en ves de recibir un cursor referenciado
         de contratos recibe una cadena de contratos separados por el caracter ,
         ya que .Net no puede mandar un cursor referenciado como variable de entrada.
         Se crea el método getCurContratos el cual se encarga de convertir una cadena
         de contratos en un cursor referenciado.
        de la suscripcion.
        </Modificacion>
         <Modificacion Autor="cdominn" Fecha="22-Feb-2012" Inc="OC183440">
            Se adiciona el método GetCupones - Para obtener una estructura de cupones
            dado una lista de contratos. 
            Se retorna :        
                NumeroCupon     NUMBER
                Contrato        NUMBER
                CodigoFactura   NUMBER
                Valor           NUMBER
                FechaPago       DATE
                FinalPago       DATE
                CodError        NUMBER
                DescError       ALFANUMERICO
        </Modificacion>

        <Modificacion Autor="aruedap" Fecha="29-Abr-2011" Inc="OC147275">
        Se reemplaza el cursor cuFactCuco por cuFactCuco1 y cuFactCuco2,
        los cuales son invocados desde el método privado Validate_Cupon.

        Se ajusta el método privado Validate_Cupon para que valide que
        el cupón ingresado pertenezca a la última factura generada para
        el contrato o a una cuenta de la última factura teniendo en cuenta
        el tipo de cupón. Si el tipo de cupón es FA o CA se consulta por
        medio del cursor cuFactCuco1, y si es CC se consulta por medio del
        cursor cuFactCuco2.

        Se obtiene los valores de los parámetros CUPON_FACTURA, CUPON_CUENCUAG 
        y CUPON_CUENCOBR que corresponden a FA, CA y CC. Son utilizados para
        tomar la decisión de cual cursor obtener la información, si de cuFactCuco1
        o cuFactCuco2.
        </Modificacion>

        <Modificacion Autor="aruedap" Fecha="10-Jun-2010" Inc="OC102424">
        Se crea función fnuGetDigitoChequeo que se encarga de retornar los
        digitos de chequeo para un cupón ingresado. Esta función es utilizada
        por el submétodo Consultar del método GetDataCupon.
        </Modificacion>

        <Modificacion Autor="aruedap" Fecha="09-Jun-2010" Inc="OC102424">
        Se ajusta el método público GetDataCupon:
        * Se modifica la definición del tipo de dato del parámetro de entrada "inuCupoNume":
          + Se cambio "cupon.cuponume%TYPE" por "NUMBER" ya que puede recibir
            un valor de mayor tamaño que el campo CUPONUME de la tabla CUPON
            por la adición de los digitos de chequeo.
        * Se invoca el método Pkg_Epm_Recaudo_OnLine.prSplitValidateCoupon que
          se encarga de separar los digitos de chequeo del número del cupón, y
          valida que los digitos de chequeo ingresados correspondan al número
          del cupón.
        * Se ajusta el submétodo "Consultar" para que retorne en el cursor
          referenciado el número de cupón concatenado con los digitos de
          chequeo.

        Se crea cursor cuFactCuco que obtiene la factura asociada al
        documento soporte de un determinado cupón.

        Se ajusta el método privado Validate_Cupon para que valide que
        el cupón ingresado pertenezca a la última factura generada para
        el contrato o a una cuenta de la última factura.

        Se ajustaron los mensajes que genera el API para que utilice
        las constantes de módulo y división definidas en pkg_epm_utilidades.

        Se adiciono el manejo de trazas en cada uno de los método privados y
        públicos del paquete.
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="20-Ago-2009" Inc="OC61239">
        Version inicial del paquete para obtener los datos asociados al cupon de pago
        de la suscripcion.
        </Modificacion>        
    </Historial>
    </Package>
******************************************************************************/
     TYPE tyrcValorHora IS RECORD(  COSSSESU CONSSESU.COSSSESU%TYPE, --Producto
                                    COSSFERE CONSSESU.COSSFERE%TYPE, --Fecha Excedente
                                    HORAEXCE CONSSESU.COSSCOCA%TYPE, --Hora Excedente
                                    TCONDESC TIPOCONS.TCONDESC%TYPE, --Descripción Tipo de Consumo
                                    NUUNEXCE CARGOS.CARGUNID%TYPE, --Numero de unidades Excedentes
                                    PRECBOLS FA_COSTMAHO.COMACOST%TYPE, --Precio Bolsa
                                    VALOUNID CARGOS.CARGVALO%TYPE, --Valor Unidades
                                    COSSPECS CONSSESU.COSSPECS%TYPE, --Periodo de Consumo
                                    PECSFECI PERICOSE.PECSFECI%TYPE, --Fecha Inicial Periodo Consumo
                                    PECSFECF PERICOSE.PECSFECF%TYPE  --Fecha Final Periodo Consumo
                                );

    TYPE tytbValorHora IS TABLE OF tyrcValorHora INDEX BY VARCHAR2(50);

    ----------------------------------------------
    -- Metodos Publicos
    ----------------------------------------------
    TYPE tyrcFecConsEx IS RECORD  
    (
        FechaExced      PERIFACT.PEFAFEPA%TYPE,
        HoraExcede      NUMBER,
        NumUniExce      NUMBER,
        PreciBolsa      NUMBER,
        ValoUnidEx      NUMBER
    );  
    
    TYPE tytbFecConsEx IS TABLE OF tyrcFecConsEx INDEX BY PLS_INTEGER;  
    
    
    TYPE tyrcDatos IS RECORD  
    (
        NumeroCupon     NUMBER,
        Contrato        SUSCRIPC.SUSCCODI%TYPE,
        CodigoFactura   FACTURA.FACTCODI%TYPE,
        ValorCupon      CUPON.CUPOVALO%TYPE,
        FechaPago       PERIFACT.PEFAFEPA%TYPE,
        FinalPago       PERIFACT.PEFAFFPA%TYPE,
        Saldo           NUMBER,
        TipoCupon       CUPON.CUPOTIPO%TYPE
    );

    TYPE tyrcDatosCupon IS RECORD
    (
        NumeroCupon     NUMBER,
        Contrato        SUSCRIPC.SUSCCODI%TYPE,
        CodigoFactura   FACTURA.FACTCODI%TYPE,
        ValorCupon      CUPON.CUPOVALO%TYPE,
        FechaPago       PERIFACT.PEFAFEPA%TYPE,
        FinalPago       PERIFACT.PEFAFFPA%TYPE,
        CodError        GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        DescError       VARCHAR2(2000)
    );
    ----------------------------------------------
    -- GetDataCupon
    ----------------------------------------------
    PROCEDURE GetDataCupon
    (
        inuCupoNume     IN  NUMBER,
        inuSuscCodi     IN  SUSCRIPC.SUSCCODI%TYPE,
        orcRecordSet    OUT SYS_REFCURSOR,
        onuCodigoError  OUT Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError OUT Pkg_Epm_Utilidades.tymensajeerror
    );

    PROCEDURE GetCupones
    (
        ircRecordSet    IN  SYS_REFCURSOR,
        orcRecordSet    OUT SYS_REFCURSOR,
        onuCodigoError  OUT Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError OUT Pkg_Epm_Utilidades.tymensajeerror
    );
    
    PROCEDURE GetCupones
    (
        isbContratos    IN  VARCHAR2,
        orcRecordSet    OUT SYS_REFCURSOR,
        onuCodigoError  OUT Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError OUT Pkg_Epm_Utilidades.tymensajeerror
    );

    FUNCTION fnuGetDigitoChequeo
    (
        inuCupoNume  IN  CUPON.CUPONUME%TYPE
    )
    RETURN NUMBER; 

    ----------------------------------------------
    -- GetLatestInvoices
    ----------------------------------------------
    PROCEDURE GetLatestInvoices
    (
        inuSuscCodi      IN   SUSCRIPC.SUSCCODI%TYPE,
        orcRecordSet     OUT  SYS_REFCURSOR,
        onuCodigoError   OUT  pkg_Epm_Utilidades.tyCodigoError,
        osbMensajeError  OUT  pkg_Epm_Utilidades.tyMensajeError
    );

    PROCEDURE pGetInvoiceDetail
    (
        inuFactcodi      IN   FACTURA.FACTCODI%TYPE,
        orcRecordSet     OUT  SYS_REFCURSOR,
        onuErrorCode     OUT  pkg_Epm_Utilidades.tyCodigoError,
        osbErrorMsg      OUT  pkg_Epm_Utilidades.tyMensajeError
    );

    PROCEDURE pGetServicesByAddress
    (
        isbPais           IN   GST_PAIS.PAISCODI%TYPE,
        inuDepartamento   IN   NUMBER,
        inuMunicipio      IN   NUMBER,
        isbDireccion      IN   AB_ADDRESS.ADDRESS_PARSED%TYPE,
        orcRecordSet      OUT  SYS_REFCURSOR,
        onuCodigoError    OUT  pkg_epm_utilidades.tyCodigoError,
        osbMensajeError   OUT  pkg_epm_utilidades.tyMensajeError
    );
    
    FUNCTION fdtFechaPagoFact
    (
        inuFactura  IN  FACTURA.FACTCODI%TYPE
    )
    RETURN CUENCOBR.CUCOFEPA%TYPE;

    FUNCTION fsbGetPagado
    (
        inuCupon  IN CUPON.CUPONUME%TYPE
    )
    RETURN CUPON.CUPOFLPA%TYPE;
    
    PROCEDURE ColecConsulta
    (
        ircRecordSet      IN   SYS_REFCURSOR,
        inuIndice         IN   NUMBER,
        onuIndice         OUT  NUMBER,
        onuCodigoError    OUT  Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError   OUT  Pkg_Epm_Utilidades.tymensajeerror
    );

    PROCEDURE InicializarErr
    (
        onuCodigoError  OUT Pkg_Epm_Utilidades.TYCODIGOERROR,
        osbMensajeError OUT Pkg_Epm_Utilidades.TYMENSAJEERROR
    );

    FUNCTION fsbVersion RETURN VARCHAR2;
    
    FUNCTION fnuObtValFactura (inuFactura FACTURA.FACTCODI%TYPE) RETURN NUMBER;
    
    /* Liquida el excedente de energía exportada por encima del consumo */
    PROCEDURE GetExcedentesEnergia
    (
        inuContrato     IN  servsusc.sesususc%type,
        inuPeriodFact   IN  perifact.pefacodi%type,
        orfValoresHora  OUT pkConstante.tyrefcursor,
        onuCodigoError  OUT Pkg_Epm_Utilidades.TYCODIGOERROR,
        osbMensajeError OUT Pkg_Epm_Utilidades.TYMENSAJEERROR
    );    
    FUNCTION fnuValorCuponAnticipado
    (        
        inuCupon IN cupon.cuponume%type,
        inuSaldoFactura IN NUMBER        
    )
    RETURN NUMBER;

END pkg_Epm_WebCoupon;
/
CREATE OR REPLACE PACKAGE BODY pkg_Epm_WebCoupon
AS

    -- Para el control de traza:
    csbSP_NAME                  CONSTANT VARCHAR2(32)                 := 'pkg_Epm_WebCoupon.';
    cnuNVLTRC                   CONSTANT NUMBER(2)                    := pkg_epm_constante.fnuNVL_BO;
    csbPUSH                     CONSTANT VARCHAR2(4)                  := pkg_epm_Constante.fsbPUSH   ;
    csbPOP                      CONSTANT VARCHAR2(4)                  := pkg_epm_Constante.fsbPOP    ;
    csbPOP_ERC                  CONSTANT VARCHAR2(4)                  := pkg_epm_Constante.fsbPOP_ERC;
    csbPOP_ERR                  CONSTANT VARCHAR2(4)                  := pkg_epm_Constante.fsbPOP_ERR;
    
    
    -----------------------
    -- Variables Privadas
    -----------------------
    
    -- Numero de Registros Referenciados
    nuNumTrans                INTEGER := 0;
    nuNumTraCc                INTEGER := 0;
    nuNumTraPp                INTEGER :=0;
    
    -- Mensajes de Error
    sbErrMsg                  pkg_Epm_Utilidades.tyMensajeError;
    -----------------
    -- Constantes
    -----------------
    csbVersion                CONSTANT pkg_epm_Utilidades.tyVersion := 'WO0000000456709'; -- Ultima Oc que modifico el Paquete

    tblDatFacWeb_EMPTY        epm_tyDatFacWeb := epm_tyDatFacWeb(epm_tyObjDatFacWeb(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL));
    tblDatFacWeb              epm_tyDatFacWeb;

    tblCurDetFacWeb_EMPTY     epm_tyDetFacWeb := epm_tyDetFacWeb(epm_tyObjDetFacWeb(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL));
    tblCurDetFacWeb           epm_tyDetFacWeb;


    TYPE tyMonths IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    tsbMonths                 tyMonths;

    -- Mensajes
    cnuINVALID_NOEXIST        CONSTANT NUMBER :=  1065;   -- Cupon no existe OPF - SAT
    cnuINVALID_PARAVAL        CONSTANT NUMBER := 10599;   -- El cupon y la suscripcion no pueden ser nulos EPM - BIL
    cnuINVALID_CUPOSUS        CONSTANT NUMBER := 10600;   -- El cupon no pertenece a la suscripcion EPM - BIL
    cnuINVALID_NOSUSCR        CONSTANT NUMBER := 10050;   -- Suscripcion No Existe EPM - BIL
    cnuINVALID_NOCUPON        CONSTANT NUMBER := 10601;   -- No existe cupon para la ultima factura EPM - BIL
    cnuINVALID_CUPODOC        CONSTANT NUMBER := 10620;   -- La factura y/o cuenta del cupon no existe EPM - BIL
    cnuINVALID_CUPO_ULT_FACT  CONSTANT NUMBER := 10755;   -- El cupón [%s1] no pertenece a la última factura generada para el contrato o a una cuenta de la última factura.
    cnuINVALID_NOFACTURA      CONSTANT NUMBER := 12489;   -- No se encontraron facturas en los ultimos [%s1] dias para el contrato ingresado.
    cnuINVALID_CUPONPAGADO  CONSTANT NUMBER := 6160; -- El cupón [%s1] no está disponible para ser pagado.
    cnuINVALID_SOLIESTACUPON  CONSTANT NUMBER := 6161; -- El cupón [%s1] no es válido para realizar pagos on line. Tipo solicitud: [%s2] - Estado: [%s3].    
    cnuPERIODOS_MAYOR_PARAM   CONSTANT NUMBER := 16132;   -- El contrato consultado no está listo para ser cancelado

    -- Parámetros
    csbCUPON_FACT             CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fsbget('EPM_CUPON_FACTURA'),' ','');
    csbCUPON_CUCO             CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fsbget('EPM_CUPON_CUENCOBR'),' ','');
    csbCUPON_CUAG             CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_EPM_BOParametr.fsbGet('EPM_CUPON_CUENCUAG'),' ','');    
    csbCUPON_PAAN             CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_EPM_BOParametr.fsbGet('EPM_CUPON_PAGOAN'),' ',''); 
    csbEPM_SOLICITUDES_PAGOAN CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_EPM_BOParametr.fsbGet('EPM_SOLICITUDES_PAGOAN'),' ','');
    csbEPM_ESTADOS_PAGOAN     CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_EPM_BOParametr.fsbGet('EPM_ESTADOS_PAGOAN'),' ','');
    csbCUPON_APFA             CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_EPM_BOParametr.fsbGet('EPM_CUPON_APLIFACT'),' ','');
    csbCUPON_FINA             CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_EPM_BOParametr.fsbGet('EPM_CUPON_FINANCIA'),' ','');
    csbCUPON_NEGO             CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_EPM_BOParametr.fsbGet('EPM_CUPON_NEGOCIAC'),' ','');
    csbSOLICITUD_IMPA         CONSTANT EPM_PARAMETR.VALUE%TYPE := pkg_EPM_BOParametr.fnuGet('EPM_SOLICITUD_IMPA'); --VJIMENEC        
    cnuMET_CAL_CONSFACT       CONSTANT PARAMETR.PAMENUME%TYPE  := replace(pkg_EPM_BOParametr.fnuGet('EPM_MECC_FACTURADO'),' ','');
    cnuBIL_MAX_DIAS_ESPER_F   CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fnuGet('EPM_DIAS_ANUL_TRAMI_FINA'),' ','');
    csbFormatoFecha           CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fsbGet ('EPM_FORMADATE_RECAVT'),' ','');
    csbConcepTypeCons         CONSTANT EPM_PARAMETR.VALUE%type := replace(pkg_epm_boparametr.fsbGet('EPM_CONCTIPCON_CREG_030'),' ','');
    csbEPM_PROG_FACT_PAGO_LINEA CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fsbGet ('EPM_PROG_FACT_PAGO_LINEA'),' ','');
    csbEPM_CUPOPROG_EXCLWEB     CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fsbGet ('EPM_CUPOPROG_EXCLWEB'),' ','');
    csbEPM_TIPOCUPO_EXCLWEB     CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fsbGet ('EPM_TIPOCUPO_EXCLWEB'),' ','');
    csbEPM_IMP_PLAN_CREG030     CONSTANT EPM_PARAMETR.VALUE%TYPE := replace(pkg_epm_boparametr.fsbGet ('EPM_IMP_PLAN_CREG030'),' ','');

    -- tipos consumos acumulados consulta de deuda
    csbEPM_TIPOCONS_FACTWEB constant  ge_parameter.value%type := pkg_EPM_BOParametr.fsbGet('EPM_TIPOCONS_FACTWEB');

    cnuMAX_NUMERO_PERIODOS    NUMBER;

    -- Numero de (n) ultimas facturas a retornar en la consulta
    cnuNUMEULTI_FACTWEB       NUMBER;

    -- Id Error
    csbDIVISION               CONSTANT   MENSAJE.MENSDIVI%TYPE := Pkg_Epm_Utilidades.csbDivisionOPF;
    csbDivisionEPM            CONSTANT   MENSAJE.MENSDIVI%TYPE := Pkg_Epm_Utilidades.csbDivisionEPM;
    csbMODULE                 CONSTANT   MENSAJE.MENSMODU%TYPE := Pkg_Epm_Utilidades.csbModuloSAT;
    csbModuloBIL              CONSTANT   MENSAJE.MENSMODU%TYPE := Pkg_Epm_Utilidades.csbModuloBIL;
    csbModuloCUZ              CONSTANT   MENSAJE.MENSMODU%TYPE := Pkg_Epm_Utilidades.csbModuloCUZ;
    cnuNOCACHE                CONSTANT   INTEGER := pkConstante.NOCACHE;

    -- Periodicidad, indicador de lectura y ultima factura
    gnuFrecLect               PE_PER_HIS_PROD.PERIODICITY%TYPE;
    gnuFactCodi               FACTURA.FACTCODI%TYPE;
    gtbGeneral                epm_tyGeneral;
    gtbGeneral_Empty          epm_tyGeneral := epm_tyGeneral(epm_tyObjGeneral);
    nuIndiceIn                NUMBER;
    nuIndiceOut               NUMBER;
    
    ----------------------------------------------
    -- Objetos Types
    ----------------------------------------------
    tbFacturas epm_tyGeneral;
    tbFacturasEmpty epm_tyGeneral := epm_tyGeneral(epm_tyObjGeneral);
    
    --Cupones Pago Anticipado
    tbCuponesPP epm_tyGeneral;
    tbCuponesPPEmpty epm_tyGeneral := epm_tyGeneral(epm_tyObjGeneral);
    
    -----------------------
    -- Cursores
    -----------------------
    -- Cursor para acceder a CUPON
    CURSOR cuCupon
    (
       inuCupoNume  IN  CUPON.CUPONUME%TYPE
    )
       IS
       SELECT cuponume, cupodocu, cupotipo, cupovalo
         FROM cupon
        WHERE cuponume = inuCupoNume
          AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||',',','||cupotipo||',') = 0
          AND cupovalo > 0
          AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER( NVL(cupoprog, '-') )||',') = 0;
          
    -- Cursor para accesar FACTURA
    CURSOR cuFactura
    (
       inuFactCodi  IN  FACTURA.FACTCODI%TYPE
    )
       IS
       SELECT factsusc, factpefa, factcodi, factfege
         FROM factura
        WHERE factcodi = inuFactCodi;

    -- Cursor para accesar CUENCOBR
    CURSOR cuCuenCobr
    (
       inuCucoCodi  IN  CUENCOBR.CUCOCODI%TYPE
    )
       IS
       SELECT factsusc, factpefa, cucofact, NVL(cucosacu, 0) cucosacu
         FROM cuencobr, factura
        WHERE cucocodi = inuCucoCodi
          and cucofact = factcodi;

    -- Cursor para accesar ultima FACTURA Suscriptor
    CURSOR cuUltFactura
    (
       inuFactSusc  IN  FACTURA.FACTSUSC%TYPE
    )
    IS
    SELECT /*+ INDEX(factura ix_factura06 ) */
           factsusc, factpefa, factcodi, factfege
      FROM factura
     WHERE factsusc = inuFactSusc
       AND factnufi > 0
       AND instr(','||csbEPM_PROG_FACT_PAGO_LINEA||',',','||factprog||',') > 0            
       AND EXISTS( SELECT '1' FROM cupon WHERE cupodocu = TO_CHAR(factcodi) )
       AND facttico = 1
    UNION ALL
    SELECT /*+ INDEX(factura ix_factura06 ) */
           factsusc, factpefa, factcodi, factfege
      FROM factura
     WHERE factsusc = inuFactSusc
       AND factnufi > 0
       AND instr(','||csbEPM_PROG_FACT_PAGO_LINEA||',',','||factprog||',') > 0
       AND EXISTS( SELECT '1' FROM cupon WHERE cupodocu IN ( SELECT TO_CHAR(cucocodi) FROM cuencobr WHERE cucofact = factcodi ))
       AND facttico = 1
     ORDER BY factfege DESC, factcodi DESC;
     
    -- Cursor para accesar ultima FACTURA Anterior Suscriptor
    CURSOR cuUltFacturaAnt
    (
       inuFactSusc  IN  FACTURA.FACTSUSC%TYPE,
       inuFactCodi  IN  FACTURA.FACTCODI%TYPE
    )
    IS
    SELECT /*+ INDEX(factura ix_factura06 ) */
           factsusc, factpefa, factcodi, factfege
      FROM factura
     WHERE factsusc = inuFactSusc
       AND factcodi < NVL(inuFactCodi, 9999999999)
       AND factnufi > 0
       AND instr(','||csbEPM_PROG_FACT_PAGO_LINEA||',',','||factprog||',') > 0
       AND EXISTS
       (        
            SELECT  '1' 
            FROM    cupon 
            WHERE   cupodocu = TO_CHAR(factcodi) 
            AND     instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER( NVL(cupoprog, '-') )||',') = 0
       )
       AND facttico = 1
    UNION ALL
    SELECT /*+ INDEX(factura ix_factura06 ) */
           factsusc, factpefa, factcodi, factfege
      FROM factura
     WHERE factsusc = inuFactSusc
       AND factcodi < NVL(inuFactCodi, 9999999999)
       AND factnufi > 0
       AND instr(','||csbEPM_PROG_FACT_PAGO_LINEA||',',','||factprog||',') > 0
       AND EXISTS
       ( 
            SELECT  '1' 
            FROM    cupon WHERE cupodocu IN ( SELECT TO_CHAR(cucocodi) FROM cuencobr WHERE cucofact = factcodi )
            AND     instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER( NVL(cupoprog, '-') )||',') = 0
       )
       AND facttico = 1
     ORDER BY factfege DESC, factcodi DESC;
     
    -- Cursor para accesar CUPON Ultima Factura Documento
    CURSOR cuUltCupon
    (
       isbCupoDocu       IN  CUPON.CUPODOCU%TYPE
    )
    IS
        WITH CuponPadre AS
        (
           SELECT MAX(cuponume) cuponume, cupodocu, cupotipo, cupovalo
             FROM cupon
            WHERE cupodocu = isbCupoDocu
              AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||',',','||cupotipo||',') = 0
              AND cupovalo > 0
              AND cupocupa IS NULL
              AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER( NVL(cupoprog, '-') )||',') = 0          
            GROUP BY cupodocu, cupotipo, cupovalo
        )
        SELECT Cupon.cuponume, Cupon.cupodocu, Cupon.cupotipo, Cupon.cupovalo
          FROM Cupon, CuponPadre
         WHERE CuponPadre.cuponume = cupon.cupocupa
         UNION ALL
        SELECT CuponPadre.*
          FROM CuponPadre
         ORDER BY 1 DESC;
         
    -- Cursor para accesar CUPON Ultima Cuenta Documento
    CURSOR cuUltCupcc
    (
       inuCucoFact  IN  CUENCOBR.CUCOFACT%TYPE
    )
    IS
       SELECT Cupones.* FROM
       (
       SELECT MAX(cuponume) cuponume, cupodocu, cupotipo, cupovalo
         FROM cupon, (
                        SELECT factsusc, factpefa, cucocodi
                          FROM cuencobr, factura
                         WHERE cucofact = inuCucoFact
                           AND cucofact = factcodi
                     ) DATA_CUCO
        WHERE cupodocu = TO_CHAR(DATA_CUCO.cucocodi)
          AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||',FA,CA'||',',','||cupotipo||',') = 0
          AND cupovalo > 0
          AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER( NVL(cupoprog, '-') )||',') = 0
        GROUP BY cupodocu, cupotipo, cupovalo
        ) Cupones, Cupon
        WHERE
        Cupones.cuponume = Cupon.cupocupa
        UNION ALL
       SELECT MAX(cuponume) cuponume, cupodocu, cupotipo, cupovalo
         FROM cupon, (
                        SELECT factsusc, factpefa, cucocodi
                          FROM cuencobr, factura
                         WHERE cucofact = inuCucoFact
                           AND cucofact = factcodi
                     ) DATA_CUCO
        WHERE cupodocu = TO_CHAR(DATA_CUCO.cucocodi)
          AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||',FA,CA'||',',','||cupotipo||',') = 0
          AND cupovalo > 0
          AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER( NVL(cupoprog, '-') )||',') = 0
        GROUP BY cupodocu, cupotipo, cupovalo
        ORDER BY 1 DESC;

    -- Cursor para obtener el contrato y la factura asociada
    -- al documento soporte del cupón.
    CURSOR cuFactCuco1 (sbDocumento  IN  CUPON.CUPODOCU%TYPE) IS
        SELECT factsusc contrato, factcodi factura
          FROM factura
         WHERE factcodi = sbDocumento;

    -- Cursor para obtener el contrato y la factura asociada
    -- al documento soporte del cupón.
    CURSOR cuFactCuco2 (sbDocumento  IN  CUPON.CUPODOCU%TYPE) IS
        SELECT factsusc contrato, cucofact factura
          FROM cuencobr, factura
         WHERE cucocodi = sbDocumento
           AND cucofact = factcodi;

    -- Consultar datos del cupón de FINANCIACION de un contrato
    CURSOR cuFinancia (inuSuscripcion  IN  SUSCRIPC.SUSCCODI%TYPE)
    IS
    SELECT /*+ INDEX(p idx_pr_product_010) INDEX(mv ix_mo_motive01) INDEX(mo pk_mo_packages) INDEX(cc idx_cc_financing_request04) */
           p.subscription_id,
           cc.financing_request_id,
           cc.coupon_id,
           TRUNC(cc.record_date) record_date,
           package_type_id
      FROM pr_product p, mo_motive mv, mo_packages mo, cc_financing_request cc
     WHERE p.subscription_id = inuSuscripcion
       AND mv.product_id = p.product_id     
       AND mv.package_id = mo.package_id
       AND cc.subscription_id = p.subscription_id
       AND mo.package_id = cc.package_id
       AND cc.wait_by_payment = 'Y'
     ORDER BY mo.request_date DESC;
     
    -- Consultar los datos de un cupón
    CURSOR cuCuponDoc (isbCupoDocu  IN  CUPON.CUPODOCU%TYPE)
    IS
    SELECT cuponume, cupodocu, cupotipo, cupovalo, cupoajus
      FROM cupon
     WHERE cupodocu = isbCupoDocu;
     
      -- Consultar los datos de un cupón Pago Anticipado x Contrato
    CURSOR cuCuponSusPP (inuCupoSusc  IN  CUPON.CUPOSUSC%TYPE,
                                         isbCupoTipo   IN   CUPON.CUPOTIPO%TYPE,
                                         isbCupoFlpa IN CUPON.CUPOFLPA%TYPE)
    IS
    SELECT cuponume
      FROM cupon
     WHERE cuposusc = inuCupoSusc
          AND cupotipo = isbCupoTipo
          AND cupoflpa = isbCupoFlpa
          AND cupovalo > 0
          AND NOT EXISTS (
                                        SELECT pagocupo
                                          FROM pagos
                                        WHERE pagocupo = cuponume
                                    );
     
     -- Consultar los datos de un cupón Pago Anticipado x Cupon
    CURSOR cuCuponNum (inuCupoNume  IN  CUPON.CUPONUME%TYPE,
                                      isbCupoTipo   IN   CUPON.CUPOTIPO%TYPE,
                                      isbCupoFlpa IN CUPON.CUPOFLPA%TYPE)
    IS
    SELECT cuponume, cupodocu, cupotipo, cupovalo, cupoajus, cuposusc, package_type_id, motive_status_id
      FROM cupon INNER JOIN mo_packages
          ON cupodocu = package_id
     WHERE cuponume = inuCupoNume
          AND cupotipo = isbCupoTipo
          AND cupoflpa = isbCupoFlpa;
              
    -- Consulta de validación de estado y solicitud del cupon de pago anticipado
    CURSOR cuCuponSolEst (isbCopuDocu IN MO_PACKAGES.PACKAGE_ID%TYPE)
    IS 
    SELECT package_id 
      FROM mo_packages
     WHERE package_id = isbCopuDocu
       AND instr(','||csbEPM_SOLICITUDES_PAGOAN||',',','||package_type_id||',') > 0
       AND instr(','||csbEPM_ESTADOS_PAGOAN||',',','||motive_status_id||',') > 0;
    
    -- Registro Cursor
    rcCupon                   cuCupon%ROWTYPE;
    rcCuponDoc                cuCuponDoc%ROWTYPE;
    rcFactura                 cuFactura%ROWTYPE;
    rcCuenCobr                cuCuenCobr%ROWTYPE;
    rcFactCuco                cuFactCuco1%ROWTYPE;
    rcFinancia                cuFinancia%ROWTYPE;
    rcCuponSusPP              cuCuponSusPP%ROWTYPE;
    rcCuponNum                cuCuponNum%ROWTYPE;
    rcCuponSolEst             cuCuponSolEst%ROWTYPE;
    
    ----------------------------------------------
    -- Metodos Privados
    ----------------------------------------------
    -- Metodo privado para obtener el saldo de un cupo FA de pago anticipado
    FUNCTION fnuValorCuponAnticipado
    (        
        inuCupon IN cupon.cuponume%type,
        inuSaldoFactura IN NUMBER        
    )
    RETURN NUMBER
    IS  
        -- Cursor Datos del Cupón - Solicitud
        CURSOR cuDatosCuponSoli
        (
             inuCupo IN NUMBER
        )
        IS
        SELECT COUNT(1) N
        FROM   cupon,
               rc_cuposoli,
               mo_packages
        WHERE  cuponume = inuCupon
        AND    cuponume = cusonume
        AND    cusosoli = package_id
        AND    package_type_id = csbSOLICITUD_IMPA;
        
        rcDatosCuponSoli  cuDatosCuponSoli%ROWTYPE;    
        rcCupon  cupon%ROWTYPE;
        nuSaldo  cuencobr.cucosacu%TYPE;
        
    BEGIN
        -- Obtiene el registro del cupón
        rcCupon := pktblcupon.frcgetrecord(inuCupon);
        
        -- Asigna Saldo Recibido por Parametro
        nuSaldo := inuSaldoFactura; 
        
        -- validat tipo cupon
        IF(rcCupon.CUPOTIPO = csbCUPON_FACT) THEN
        
            -- valida si el cupon es de solicitud
            OPEN  cuDatosCuponSoli(inuCupon);
            FETCH cuDatosCuponSoli INTO rcDatosCuponSoli;
            CLOSE cuDatosCuponSoli;
            
            -- si es un cupon de pago anticipafo
            IF(rcDatosCuponSoli.N > 0 AND UPPER(rcCupon.CUPOFLPA) = 'N') THEN            
                nuSaldo :=  rcCupon.CUPOVALO;
            END IF;   
        
        END IF;    
        RETURN nuSaldo;    
    END;
    
    FUNCTION fnuGetCtaVencSusc( inuSesususc IN SERVSUSC.SESUSUSC%TYPE )
    RETURN NUMBER IS
     
        CURSOR cuServsusc IS
            SELECT  SESUNUSE
            FROM    SERVSUSC
            WHERE   SESUSUSC = inuSesususc;
            
        TYPE tyTbServsusc IS TABLE OF cuServsusc%ROWTYPE INDEX BY BINARY_INTEGER;
        tbServsusc  tyTbServsusc;
        nuIdx       NUMBER := 0;    
        
        nuCtaVenSusc        NUMBER := 0;
        nuCtrlCtaVen        NUMBER := 0;
    BEGIN
        pkErrors.Push('pkg_Epm_WebCoupon.fnuGetCtaVencSusc');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.fnuGetCtaVencSusc',4);

        tbServsusc.DELETE;

        IF cuServsusc%ISOPEN THEN
            CLOSE cuServsusc;    
        END IF;
        OPEN cuServsusc;
        FETCH cuServsusc BULK COLLECT INTO tbServsusc;
        CLOSE cuServsusc;

        nuIdx := tbServsusc.FIRST;
        LOOP
            EXIT WHEN nuIdx IS NULL;
            
            nuCtrlCtaVen := 0;
            nuCtrlCtaVen := Pkg_Epm_Businessquerys.fnuCuentasVencidasServicio(inuSesususc , SYSDATE);
            
            IF (nuCtrlCtaVen > nuCtaVenSusc) THEN
                 nuCtaVenSusc := nuCtrlCtaVen;
            END IF;
            
            nuIdx := tbServsusc.NEXT(nuIdx);
        END LOOP;

        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.fnuGetCtaVencSusc',4);
        pkErrors.Pop;

        RETURN nuCtaVenSusc;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fnuGetCtaVencSusc',4);            
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fnuGetCtaVencSusc',4);            
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fnuGetCtaVencSusc',4);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END fnuGetCtaVencSusc;

    /******************************************************************************
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>pValidate_Periodos</Unidad>
    <Descripcion>
    Verifica que la cantidad de periodos de facturación del ciclo del contrato que han transcurrido 
    desde el periodo de la factura no superen al dado por el parámetro EPM_PERVAL_WEBCUPON.
    Si lo superan se hace raise con el mensaje de error 16132
    </Descripcion>
    <Autor>José Lubin Pineda ( jpinedc ) Axede S.A</Autor>
    <Fecha>28-Jul-2014</Fecha>
    <Parametros>
        <param nombre="inuSuscCodi" tipo="suscripc.susccodi%TYPE" direccion="IN">Codigo de la Suscripcion.</param>
        <param nombre="inuPefaCodi" tipo="perfact.pefacodi%TYPE" direccion="IN">Codigo del periodo de facturacion del documento.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="jpinedc" Fecha="28-Jul-2014" Inc="OC402523">
        Creacion del Metodo.
        </Modificacion>
    </Historial>
    </Procedure>
    ******************************************************************************/

    PROCEDURE pValidate_Periodos
    (
        inuSUSCCODI     IN   SUSCRIPC.SUSCCODI%TYPE,
        inuPEFACODI     IN   PERIFACT.PEFACODI%TYPE
    )
    IS
        SBFORMATOFECHA      VARCHAR2(10) := 'DD/MM/YYYY';
        DTPEFADOCUMENTO     DATE;
        DTPEFAACTUAL        DATE;
        nuCANTPERIODOS      NUMBER;

        -- Ciclo del contrato        
        CURSOR CU_SUSCRIPC
        (
            INUSUSCCODI     IN  SUSCRIPC.SUSCCODI%TYPE
        )
        IS
        SELECT
        SUSCCICL
        FROM
        SUSCRIPC
        WHERE
        SUSCCODI = INUSUSCCODI;

        RCSUSCRIPC      CU_SUSCRIPC%ROWTYPE;
        
        -- Datos el periodo
        CURSOR
        CU_PERIFACT_DOCU
        (
            INUPEFACODI     IN  PERIFACT.PEFACODI%TYPE
        )
        IS
        SELECT
        PEFAANO,
        PEFAMES
        FROM
        PERIFACT
        WHERE
        PEFACODI = INUPEFACODI;

        RCPERIFACT_DOCU     CU_PERIFACT_DOCU%ROWTYPE;      
    
        -- Datos del periodo actual  
        CURSOR
        CU_PERIFACT_ACTU
        (
            INUPEFACICL     IN  PERIFACT.PEFACICL%TYPE
        )
        IS
        SELECT
        PEFAANO,
        PEFAMES
        FROM
        PERIFACT
        WHERE
        PEFACICL = INUPEFACICL AND
        PEFAACTU = 'S';

        RCPERIFACT_ACTU     CU_PERIFACT_ACTU%ROWTYPE;    
    
        -- Cantidad de periodos que han pasado entre el documento y el periodo actual
        CURSOR
        CU_CANTPERIODOS
        (
            INUPEFACICL         IN  PERIFACT.PEFACICL%TYPE,
            IDTPEFAACTUAL       IN  DATE,
            IDTPEFADOCUMENTO    IN  DATE
        )
        IS
        SELECT
        COUNT(1) CANTIDAD
        FROM
        PERIFACT
        WHERE
        PEFACICL = INUPEFACICL AND
        TO_DATE( '01/' || PEFAMES || '/' || PEFAANO , SBFORMATOFECHA ) <= IDTPEFAACTUAL AND
        TO_DATE( '01/' || PEFAMES || '/' || PEFAANO , SBFORMATOFECHA ) > IDTPEFADOCUMENTO;
                    
    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.pValidate_Periodos');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.pValidate_Periodos',4);

        Pkg_Epm_Utilidades.Trace_SetMsg('inuSUSCCODI[' || inuSUSCCODI || ']inuPefaCodi[' || inuPefaCodi || ']' ,5);
        
        -- Se obtiene el periodo del documento( Factura o cuenta de cobro )
        OPEN CU_PERIFACT_DOCU(inuPEFACODI );
        FETCH CU_PERIFACT_DOCU INTO RCPERIFACT_DOCU;
        CLOSE CU_PERIFACT_DOCU;

        Pkg_Epm_Utilidades.Trace_SetMsg('PEFAMES_DOCU[' || RCPERIFACT_DOCU.PEFAMES || ']PEFAANO_DOCU[' ||  RCPERIFACT_DOCU.PEFAANO || ']' ,5);
                
        DTPEFADOCUMENTO := TO_DATE( '01/' || RCPERIFACT_DOCU.PEFAMES || '/'  || RCPERIFACT_DOCU.PEFAANO ,  SBFORMATOFECHA );    
        
        -- Se obtiene el ciclo del contrato
        OPEN CU_SUSCRIPC( INUSUSCCODI );
        FETCH CU_SUSCRIPC INTO RCSUSCRIPC;
        CLOSE CU_SUSCRIPC;
        
        -- Se obtiene el periodo actual
        OPEN CU_PERIFACT_ACTU( rcSuscripc.SUSCCICL );
        FETCH CU_PERIFACT_ACTU INTO RCPERIFACT_ACTU;
        CLOSE CU_PERIFACT_ACTU;
        
        Pkg_Epm_Utilidades.Trace_SetMsg('PEFAMES_ACTU[' || RCPERIFACT_ACTU.PEFAMES || ']PEFAANO_ACTU[' ||  RCPERIFACT_ACTU.PEFAANO || ']' ,5);

        DTPEFAACTUAL := TO_DATE( '01/' || RCPERIFACT_ACTU.PEFAMES || '/'  || RCPERIFACT_ACTU.PEFAANO ,  SBFORMATOFECHA );
         
        Pkg_Epm_Utilidades.Trace_SetMsg('rcSuscripc.SUSCCICL[' || rcSuscripc.SUSCCICL || ']DTPEFAACTUAL[' || DTPEFAACTUAL|| ']DTPEFADOCUMENTO[' || DTPEFADOCUMENTO ||']' ,5);

        -- Se obtiene la cantidad de periodos que han transcurrido
        OPEN CU_CANTPERIODOS( rcSuscripc.SUSCCICL, DTPEFAACTUAL, DTPEFADOCUMENTO );
        FETCH CU_CANTPERIODOS INTO nuCANTPERIODOS;
        CLOSE CU_CANTPERIODOS;

        Pkg_Epm_Utilidades.Trace_SetMsg('nuCANTPERIODOS[' || nuCANTPERIODOS || ']cnuMAX_NUMERO_PERIODOS[' || cnuMAX_NUMERO_PERIODOS || ']' ,5);

        IF ( nuCANTPERIODOS > cnuMAX_NUMERO_PERIODOS ) THEN
            --El número de períodos [%s1] es mayor que [%s2] dado por el parámetro  EPM_PERVAL_WEBCUPON (6)
            -- <Men cod="EPM-BIL- 16132">El contrato consultado presenta un número de cuentas vencidas mayor al permitido.</Men>
            pkErrors.setErrorCode (csbDivisionEPM,csbModuloBIL,cnuPERIODOS_MAYOR_PARAM);
            RAISE LOGIN_DENIED;
        END IF;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pValidate_Periodos',4);
        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pValidate_Periodos',4);
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pValidate_Periodos',4);
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pValidate_Periodos',4);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END pValidate_Periodos;

    ----------------------------------------------
    -- openCursorNull (.NET)
    ----------------------------------------------    
    PROCEDURE openCursorNull
    (
        orcRecordSet   OUT   SYS_REFCURSOR
    )
    IS
    BEGIN
        -- <Com>Cierra Cursor Referencia.</Com>
        IF (orcRecordSet%ISOPEN) THEN
            CLOSE orcRecordSet;
        END IF;
        
        -- Consulta Nulo
        OPEN orcRecordSet FOR
        SELECT TO_NUMBER(NULL) NumeroCupon, -- VARCHAR2(50)
               TO_NUMBER(NULL) Contrato,
               TO_NUMBER(NULL) CodigoFactura,
               TO_NUMBER(NULL) ValorCupon,
               TO_DATE(NULL)   FechaPago,
               TO_DATE(NULL)   FinalPago,
               TO_NUMBER(NULL) Saldo,
               TO_CHAR(NULL)   TipoCupon
          FROM DUAL;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END openCursorNull;
    ----------------------------------------------
    -- openCursorFactNull (.NET)
    ----------------------------------------------
    PROCEDURE openCursorFactNull
    (
        orcRecordSet   OUT   SYS_REFCURSOR
    )
    IS
    BEGIN
        -- <Com>Cierra Cursor Referencia.</Com>
        IF (orcRecordSet%ISOPEN) THEN
            CLOSE orcRecordSet;
        END IF;
        
        -- Consulta Nulo
        OPEN orcRecordSet FOR
        SELECT TO_NUMBER(NULL) nuFactCodi,
               TO_NUMBER(NULL) nuFactSusc,
               TO_NUMBER(NULL) nuCupoNume,
               TO_DATE(NULL)   dtCupoFech,
               TO_NUMBER(NULL) nuCupoValo,
               TO_NUMBER(NULL) nuFactVato,
               TO_NUMBER(NULL) nuFactCicl,
               TO_NUMBER(NULL) nuFactAno,
               TO_NUMBER(NULL) nuFactMes,
               TO_CHAR(NULL)   sbDescMes,
               TO_DATE(NULL)   dtFactFege,
               TO_DATE(NULL)   dtPefaFepa,
               TO_DATE(NULL)   dtPefaFfpa,
               TO_DATE(NULL)   dtFactFepa,
               TO_CHAR(NULL)   sbBanco,
               TO_CHAR(NULL)   sbOficina
          FROM DUAL;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END openCursorFactNull;
    
    
    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> InitializeDetCursor </Unidad>
    <Descripcion>
        Permite inicializar el cursor referenciado usado en el API de Consulta pkg_Epm_WebCoupon.pGetInvoiceDetail
    </Descripcion>
    <Autor> Jhonatan Hernandez Silva - AXEDE S.A </Autor>
    <Fecha> 28/09/2015 </Fecha>
    <Parametros>
    <param nombre="orcRecordSet" tipo="REF CURSOR" Direccion="IN OUT" >Cursor referenciado con valores de los grupos de servicio</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="jhernasi" Fecha="28-09-2015" Inc="OC522953">
        Creacion
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    PROCEDURE InitializeDetCursor
    (
        orcRecordSet  IN OUT  pkConstante.tyRefCursor
    )
    IS
    BEGIN

        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.InitializeDetCursor', 3);  

        -- se inicializa en NULL.
        IF ( NOT orcRecordSet%ISOPEN ) THEN

            OPEN orcRecordSet FOR
            SELECT  NULL sbGrupoServ, 
                    NULL sbServicio,
                    NULL sbUnidMedi,
                    TO_NUMBER(NULL) nuAnoCons1, 
                    TO_NUMBER(NULL) nuMesCons1,
                    TO_NUMBER(NULL) nuConsFactMes1, 
                    TO_NUMBER(NULL) nuAnoCons2, 
                    TO_NUMBER(NULL) nuMesCons2,
                    TO_NUMBER(NULL) nuConsFactMes2,
                    TO_NUMBER(NULL) nuAnoCons3, 
                    TO_NUMBER(NULL) nuMesCons3, 
                    TO_NUMBER(NULL) nuConsFactMes3,
                    TO_NUMBER(NULL) nuValorCuenta
            FROM DUAL;

        END IF;

        Pkg_Epm_Utilidades.Trace_SetMsg('Termina pkg_Epm_WebCoupon.InitializeDetCursor', 3);

    EXCEPTION
        WHEN LOGIN_DENIED or pkConstante.exERROR_LEVEL2  THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.InitializeDetCursor',3);
            RAISE;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.InitializeDetCursor',3);
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END InitializeDetCursor;
    
    
    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> InitCursorGrupoServDir </Unidad>
    <Descripcion>
        Permite inicializar el cursor referenciado usado en el API de Consulta pkg_Epm_WebCoupon.pGetServicesByAddress
    </Descripcion>
    <Autor> Ronald Eduardo Olarte - AXEDE S.A </Autor>
    <Fecha> 28/01/2016 </Fecha>
    <Parametros>
    <param nombre="orcRecordSet" tipo="REF CURSOR" Direccion="IN OUT" >Cursor referenciado con valores de los grupos de servicio</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="rolartep" Fecha="28-01-2016" Inc="OC554300">
        Creacion
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    PROCEDURE InitCursorGrupoServDir
    (
        orcRecordSet  IN OUT pkConstante.tyRefCursor
    )
    IS
    BEGIN
        
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.InitCursorGrupoServDir', 3);
            
        -- se inicializa en NULL.
        IF ( NOT orcRecordSet%ISOPEN ) THEN
            OPEN orcRecordSet FOR
            SELECT  TO_NUMBER(NULL) CONTRATO,
                    NULL            DIRECCION,
                    NULL            GRUPOSERVICIO
            FROM DUAL;
        END IF;
        
        Pkg_Epm_Utilidades.Trace_SetMsg('Termina pkg_Epm_WebCoupon.InitCursorGrupoServDir', 3);
        
    EXCEPTION
        WHEN LOGIN_DENIED or pkConstante.exERROR_LEVEL2  THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.InitCursorGrupoServDir',3);
            RAISE;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.InitCursorGrupoServDir',3);
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END InitCursorGrupoServDir;
    
    ----------------------------------------------
    -- fsbGetMonthDesc
    ----------------------------------------------
    FUNCTION fsbGetMonthDesc (inuMes IN PERIFACT.PEFAMES%TYPE)
      RETURN VARCHAR2
    IS
        -- Variables
        sbDescripcion   VARCHAR2(20);

        -- Constants
        -- Procedures
        PROCEDURE FillMonths
        IS
        BEGIN
           pkErrors.Push ('pkg_Epm_WebCoupon.FillMonths');
  
           tsbMonths(1)  := 'ENERO';
           tsbMonths(2)  := 'FEBRERO';
           tsbMonths(3)  := 'MARZO';
           tsbMonths(4)  := 'ABRIL';
           tsbMonths(5)  := 'MAYO';
           tsbMonths(6)  := 'JUNIO';
           tsbMonths(7)  := 'JULIO';
           tsbMonths(8)  := 'AGOSTO';
           tsbMonths(9)  := 'SEPTIEMBRE';
           tsbMonths(10) := 'OCTUBRE';
           tsbMonths(11) := 'NOVIEMBRE';
           tsbMonths(12) := 'DICIEMBRE';

           pkErrors.Pop;
        EXCEPTION
           WHEN LOGIN_DENIED THEN
              pkErrors.Pop;
              RAISE LOGIN_DENIED;
           WHEN pkConstante.exERROR_LEVEL2 THEN
              pkErrors.Pop;
              RAISE pkConstante.exERROR_LEVEL2;
        END FillMonths;

    BEGIN
      pkErrors.Push ('pkg_Epm_WebCoupon.fsbGetMonthDesc');
      -- Llena el array de los meses
      FillMonths;
      -- Obtiene descripcion del mes
      sbDescripcion := tsbMonths(inuMes);
      pkErrors.Pop;
      RETURN (sbDescripcion);

    EXCEPTION
      WHEN LOGIN_DENIED THEN
         pkErrors.Pop;
         RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
         pkErrors.Pop;
         RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
         pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
         pkErrors.Pop;
         RAISE_APPLICATION_ERROR (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END fsbGetMonthDesc;
    ----------------------------------------------
    -- Validate_Cupon
    ----------------------------------------------
    /******************************************************************************
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>Validate_Cupon</Unidad>
    <Descripcion>
    Valida la Consulta de Cupones para pago.
    </Descripcion>
    <Autor>Luis Fernando Cruz ( lcruzp ) Trebol Software S.A</Autor>
    <Fecha>20-Ago-2009</Fecha>
    <Parametros>
        <param nombre="inuCupoNume" tipo="cupon.cuponume%TYPE" direccion="IN">Numero del Cupon.</param>
        <param nombre="ionuSuscCodi" tipo="suscripc.susccodi%TYPE" direccion="IN OUT">Codigo de la Suscripcion.</param>
        <param nombre="onuCupoValo" tipo="cupon.cupovalo%TYPE" direccion="OUT">Valor del cupón.</param>
        <param nombre="osbCupoTipo" tipo="cupon.cupotipo%TYPE" direccion="OUT">Tipo de cupón.</param>
        <param nombre="osbCupoDocu" tipo="cupon.cupodocu%TYPE" direccion="OUT">Documento soporte del cupón.</param>
    </Parametros>
    <Historial>
    
        <Modificacion Autor="VJIMENEC" Fecha="06-May-2019" Inc="WO0000000143802">
            - Se modifica el método con el fin de incluir en las validaciones el tipo de cupón PP.
        </Modificacion>
    
        <Modificacion Autor="rolartep" Fecha="25-Ago-2014" Inc="OC392747">           
        - Se modifica el método de pkg_Epm_WebCoupon.Validate_Cupon para eliminar la lógica de pagos.
        - Se elimina el parámetro onuPagoVapa debido a que el mismo ya no es requerido para los procesos de validación.      
        </Modificacion>

        <Modificacion Autor="aruedap" Fecha="29-Abr-2011" Inc="OC147275">
        Se ajusta el método privado Validate_Cupon para que valide que
        el cupón ingresado pertenezca a la última factura generada para
        el contrato o a una cuenta de la última factura teniendo en cuenta 
        el tipo de cupón. Si el tipo de cupón es FA o CA se consulta por
        medio del cursor cuFactCuco1, y si es CC se consulta por medio del 
        cursor cuFactCuco2.
        </Modificacion>

        <Modificacion Autor="aruedap" Fecha="09-Jun-2010" Inc="OC102424">
        Se ajusta el método privado Validate_Cupon para que valide que
        el cupón ingresado pertenezca a la última factura generada para
        el contrato o a una cuenta de la última factura.
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="20-Ago-2009" Inc="OC61239">
        Creacion del Metodo.
        </Modificacion>
    </Historial>
    </Procedure>
    ******************************************************************************/
    PROCEDURE Validate_Cupon
    (
        inuCupoNume  IN     CUPON.CUPONUME%TYPE,
        ionuSuscCodi IN OUT SUSCRIPC.SUSCCODI%TYPE,
        onuCupoValo  OUT    CUPON.CUPOVALO%TYPE,        
        osbCupoTipo  OUT    CUPON.CUPOTIPO%TYPE,
        osbCupoDocu  OUT    CUPON.CUPODOCU%TYPE
    )
    IS      
    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.Validate_Cupon');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.Validate_Cupon',3);

        -- <Com>Valida Cupon Generado.</Com>
        -- Valida CUPON
        IF ( cuCupon%ISOPEN ) THEN
            CLOSE cuCupon;
        END IF;

        OPEN cuCupon (inuCupoNume);
        FETCH cuCupon INTO rcCupon;
        IF ( cuCupon%NOTFOUND ) THEN
            onuCupoValo := NULL;
        ELSE            
            onuCupoValo := rcCupon.cupovalo;
            osbCupoTipo := rcCupon.cupotipo;
            osbCupoDocu := rcCupon.cupodocu;
            -- <Com>Si encuentra cupón, se valida que pertenezca a la última factura
            -- generada para el contrato o a una cuenta de la última factura.</Com>
            -- <Com>* Si el tipo de cupon es FA o CA o AF se consulta sobre FACTURA.</Com>
            IF osbCupoTipo IN (csbCUPON_FACT, csbCUPON_CUAG, csbCUPON_APFA) THEN
                IF ( cuFactCuco1%ISOPEN ) THEN
                    CLOSE cuFactCuco1;
                END IF;
                OPEN cuFactCuco1 (osbCupoDocu);
                FETCH cuFactCuco1 INTO rcFactCuco;
                CLOSE cuFactCuco1;

            -- <Com>* Si el tipo de cupon es CC se consulta sobre CUENCOBR.</Com>
            ELSIF osbCupoTipo IN (csbCUPON_CUCO) THEN
                IF ( cuFactCuco2%ISOPEN ) THEN
                    CLOSE cuFactCuco2;
                END IF;
                OPEN cuFactCuco2 (osbCupoDocu);
                FETCH cuFactCuco2 INTO rcFactCuco;
                CLOSE cuFactCuco2;
            ELSIF osbCupoTipo IN (csbCUPON_PAAN) THEN    
                --Consulta Datos del Cupon
                OPEN cuCuponNum (inuCupoNume, csbCUPON_PAAN,'N');
              FETCH cuCuponNum INTO rcCuponNum;
                IF cuCuponNum%NOTFOUND THEN
                    CLOSE cuCuponNum;
                    pkErrors.setErrorCode (csbDivisionEPM,csbModuloCUZ, cnuINVALID_CUPONPAGADO);
                    pkErrors.changeMessage ('%s1', inuCupoNume );
                    RAISE LOGIN_DENIED;
                ELSE
                      --Consulta Solicitud y Estado Valido
                      OPEN cuCuponSolEst(rcCuponNum.cupodocu);
                    FETCH cuCuponSolEst INTO rcCuponSolEst;
                    IF cuCuponSolEst%NOTFOUND THEN
                         CLOSE cuCuponSolEst;                         
                         pkErrors.setErrorCode (csbDivisionEPM,csbModuloCUZ, cnuINVALID_SOLIESTACUPON);
                         pkErrors.changeMessage ('%s1', inuCupoNume );
                         pkErrors.changeMessage ('%s2', rcCuponNum.package_type_id );
                         pkErrors.changeMessage ('%s3', rcCuponNum.motive_status_id );
                         CLOSE cuCuponNum;
                         RAISE LOGIN_DENIED;     
                    END IF;
                    CLOSE cuCuponSolEst;
                END IF;
                CLOSE cuCuponNum;
            END IF;
            
            -- Se valida segun tipo de cupón.
            IF ( osbCupoTipo NOT IN (csbCUPON_FINA, csbCUPON_NEGO,csbCUPON_PAAN) ) THEN
                IF ( NVL(rcFactCuco.factura, -1) != pkAccountStatusMgr.fnuGetLastAccountStatus (rcFactCuco.contrato) AND gnuFrecLect = 1 ) THEN
                    -- <Men cod="EPM-BIL-10755">El cupón [%s1] no pertenece a la última factura generada para el contrato o a una cuenta de la última factura.</Men>
                    pkErrors.setErrorCode (csbDivisionEPM,csbModuloBIL, cnuINVALID_CUPO_ULT_FACT);
                    pkErrors.changeMessage ('%s1', inuCupoNume );
                    RAISE LOGIN_DENIED;
                END IF;

            END IF;

        END IF;
        CLOSE cuCupon;

        nuNumTrans := 0;
        IF (onuCupoValo IS NOT NULL) THEN
            nuNumTrans := nuNumTrans + 1;
        END IF;        
        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.Validate_Cupon',3);
        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Cupon',3);
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Cupon',3);
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Cupon',3);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END Validate_Cupon;
    ----------------------------------------------
    -- Validate_Suscr
    ----------------------------------------------
    PROCEDURE Validate_Suscr
    (
        ionuCupoNume   IN OUT   CUPON.CUPONUME%TYPE,
        inuSuscCodi    IN       SUSCRIPC.SUSCCODI%TYPE,
        inuFactRefe    IN       FACTURA.FACTCODI%TYPE,
        onuCupoValo    OUT      CUPON.CUPOVALO%TYPE,
        osbCupoTipo    OUT      CUPON.CUPOTIPO%TYPE,
        osbCupoDocu    OUT      CUPON.CUPODOCU%TYPE
    )
    IS
        sbCupoDocu     CUPON.CUPODOCU%TYPE;        
        nuUltiPeriFact FACTURA.FACTPEFA%TYPE;
        nuIdx               BINARY_INTEGER;

    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.Validate_Suscr');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.Validate_Suscr',3);

        -- <Com>Ultima Factura del Suscriptor.</Com>
        OPEN cuUltFacturaAnt (inuSuscCodi, inuFactRefe);
        FETCH cuUltFacturaAnt INTO rcFactura;
        CLOSE cuUltFacturaAnt;

        -- <Com>Asigna Información de la Ultima Factura del Suscriptor.</Com>
        sbCupoDocu := TO_CHAR(rcFactura.factcodi);
        gnuFactCodi := TO_NUMBER(sbCupoDocu);
        DBMS_OUTPUT.PUT_LINE('--> sbCupoDocu: '||sbCupoDocu);
                        
        -- <Com>Limpia Objetos.</Com>
        tbFacturas := tbFacturasEmpty;
        nuUltiPeriFact := NULL;
        nuIdx := 1; 
        
        -- <Com>Obtiene Facturas del Ultimo Periodo de Facturación.</Com>
        OPEN cuUltFacturaAnt (inuSuscCodi, inuFactRefe);
        LOOP
            FETCH cuUltFacturaAnt INTO rcFactura;
            EXIT WHEN cuUltFacturaAnt%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE ( 'rcFactura.factcodi = ' || rcFactura.factcodi );
            --Valida Si Cambia de Periodo de Facturación
            IF nuUltiPeriFact != rcFactura.factpefa THEN
                EXIT;                
            ELSE   
                 nuUltiPeriFact := rcFactura.factpefa;
                 tbFacturas(nuIdx).sbCampo01 := rcFactura.factcodi;   
                 tbFacturas.EXTEND(1,1);
                 nuIdx := nuIdx + 1;
            END IF;           
        
        END LOOP;
        CLOSE cuUltFacturaAnt;
        
        --Elimina la Ultima Posición.
        IF nuIdx > 1 THEN tbFacturas.DELETE(tbFacturas.COUNT); END IF;
        
        -- <Com>Valida Cupones Generados para el Suscriptor.</Com>
        -- Valida CUPON Ulima Factura
        IF ( cuUltCupon%ISOPEN ) THEN
            CLOSE cuUltCupon;
        END IF;

        OPEN cuUltCupon (sbCupoDocu);
        FETCH cuUltCupon INTO rcCupon;
        IF ( cuUltCupon%NOTFOUND ) THEN
            onuCupoValo := NULL;
            ionuCupoNume := NULL;
        ELSE
            onuCupoValo := rcCupon.cupovalo;
            osbCupoTipo := rcCupon.cupotipo;
            osbCupoDocu := rcCupon.cupodocu;
            ionuCupoNume := rcCupon.cuponume;
        END IF;
        CLOSE cuUltCupon;

        -- <Com>Inicializa Variable.</Com>
        nuNumTrans := 0;
        
        -- <Com>Obtiene primer indice.</Com>
        nuIdx := tbFacturas.FIRST;
        
        -- <Com>Recorre Objeto.</Com>
        LOOP            
               EXIT WHEN nuIdx IS NULL;               
                IF (NVL(onuCupoValo, 0) > 0 ) THEN
                   FOR i IN cuUltCupon ( tbFacturas(nuIdx).sbCampo01)
                   LOOP
                       nuNumTrans := nuNumTrans + 1;
                   END LOOP;
                END IF;
               nuIdx := tbFacturas.NEXT(nuIdx); 
        END LOOP;
        
        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.Validate_Suscr',3);
        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Suscr',3);
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Suscr',3);
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Suscr',3);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END Validate_Suscr;

    ----------------------------------------------
    -- Validate_Cuenta
    ----------------------------------------------
    PROCEDURE Validate_Cuenta
    (
        ionuCupoNume   IN OUT   CUPON.CUPONUME%TYPE,
        inuSuscCodi    IN       SUSCRIPC.SUSCCODI%TYPE,
        inuFactRefe    IN       FACTURA.FACTCODI%TYPE,        
        onuCupoValo    OUT      CUPON.CUPOVALO%TYPE,
        osbCupoTipo    OUT      CUPON.CUPOTIPO%TYPE,
        osbCupoDocu    OUT      CUPON.CUPODOCU%TYPE
    )
    IS
        sbCupoDocu     CUPON.CUPODOCU%TYPE;
        nuCucoFact     CUENCOBR.CUCOFACT%TYPE;
    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.Validate_Cuenta');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.Validate_Cuenta',3);

        -- <Com>Ultima Factura del Suscriptor.</Com>
        OPEN cuUltFacturaAnt (inuSuscCodi, inuFactRefe);
        FETCH cuUltFacturaAnt INTO rcFactura;
        CLOSE cuUltFacturaAnt;

        sbCupoDocu := TO_CHAR(rcFactura.factcodi);
        DBMS_OUTPUT.PUT_LINE('--> sbCupoDocu: '||sbCupoDocu);
        gnuFactCodi := TO_NUMBER(sbCupoDocu);
        nuCucoFact := rcFactura.factcodi;

        -- <Com>Valida Cupones Generados para las Cuentas de la Factura del Suscriptor.</Com>
        -- Valida CUPON Ulima Factura
        IF ( cuUltCupcc%ISOPEN ) THEN
            CLOSE cuUltCupcc;
        END IF;

        OPEN cuUltCupcc (nuCucoFact);
        FETCH cuUltCupcc INTO rcCupon;
        IF ( cuUltCupcc%NOTFOUND ) THEN
            onuCupoValo := NULL;         
            -- ionuCupoNume := NULL; www
        ELSE
            onuCupoValo := rcCupon.cupovalo;
            osbCupoTipo := rcCupon.cupotipo;
            osbCupoDocu := rcCupon.cupodocu;
            ionuCupoNume := rcCupon.cuponume;
        END IF;
        CLOSE cuUltCupcc;

        nuNumTraCc := 0;
        IF (NVL(onuCupoValo, 0) > 0) THEN
           FOR i IN cuUltCupcc (nuCucoFact)
           LOOP
               nuNumTraCc := nuNumTraCc + 1;
           END LOOP;
        END IF;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.Validate_Cuenta',3);
        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Cuenta',3);
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Cuenta',3);
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.Validate_Cuenta',3);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END Validate_Cuenta;    
    
    /******************************************************************************
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>ValidarCuponPP</Unidad>
    <Descripcion>
    Valida la Consulta de Cupones tipo PP para pago.
    </Descripcion>
    <Autor>Victor Jimenez ( VJIMENEC )</Autor>
    <Fecha>06-May-2019</Fecha>
    <Parametros>
        <param nombre="inuCupoNume" tipo="cupon.cuponume%TYPE" direccion="IN">Numero del Cupon.</param>
        <param nombre="ionuSuscCodi" tipo="suscripc.susccodi%TYPE" direccion="IN OUT">Codigo de la Suscripcion.</param>
        <param nombre="onuCupoValo" tipo="cupon.cupovalo%TYPE" direccion="OUT">Valor del cupón.</param>
        <param nombre="osbCupoTipo" tipo="cupon.cupotipo%TYPE" direccion="OUT">Tipo de cupón.</param>
        <param nombre="osbCupoDocu" tipo="cupon.cupodocu%TYPE" direccion="OUT">Documento soporte del cupón.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="VJIMENEC" Fecha="06-May-2019" Inc="WO0000000143802">
            Creacion del Metodo.
        </Modificacion>
    </Historial>
    </Procedure>
    ******************************************************************************/
    PROCEDURE ValidarCuponPP
    (
        ionuCupoNume   IN OUT   CUPON.CUPONUME%TYPE,
        inuSuscCodi    IN       SUSCRIPC.SUSCCODI%TYPE,
        onuCupoValo    OUT      CUPON.CUPOVALO%TYPE,
        osbCupoTipo    OUT      CUPON.CUPOTIPO%TYPE,
        osbCupoDocu    OUT      CUPON.CUPODOCU%TYPE
    )
    IS  
            nuIdx               BINARY_INTEGER;
    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.ValidarCuponPP');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.ValidarCuponPP',3);
        
        --Inicializa
        nuIdx := 1;
        
        -- <Com>Cupon Pendiente de Pago por Suscripción</Com>
        IF inuSuscCodi IS NOT NULL THEN
             --Obtiene Cupones tipo PP para el Contrato
             OPEN cuCuponSusPP (inuSuscCodi, csbCUPON_PAAN,'N');
             LOOP 
                  FETCH cuCuponSusPP INTO rcCuponSusPP;
                  EXIT WHEN cuCuponSusPP%NOTFOUND;
                        
                  --Consulta Datos del Cupon
                  OPEN cuCuponNum (rcCuponSusPP.cuponume, csbCUPON_PAAN,'N');
                  FETCH cuCuponNum INTO rcCuponNum;
                  IF (cuCuponNum%FOUND) THEN
                        
                      --Valida condiciones de Solicitud y estado
                      OPEN cuCuponSolEst(rcCuponNum.cupodocu);
                      FETCH cuCuponSolEst INTO rcCuponSolEst;
                         IF (cuCuponSolEst%FOUND) THEN
                            
                               --Asigna Valores
                               onuCupoValo := rcCuponNum.cupovalo;
                               osbCupoTipo := rcCuponNum.cupotipo;
                               osbCupoDocu := rcCuponNum.cupodocu;
                               ionuCupoNume := rcCuponNum.cuponume;
                                  
                               --Adiciona valor al Arreglo
                               tbCuponesPP(nuIdx).nuCampo01 := rcCuponNum.cuponume;
                               tbCuponesPP.EXTEND(1,1);
                               nuIdx := nuIdx + 1;
                                 
                               --Aumenta Contador
                               nuNumTraPp := nuNumTraPp + 1;
                         END IF;
                         CLOSE cuCuponSolEst;
                  END IF;
                  CLOSE cuCuponNum;
             END LOOP;                    
             --Elimina la Ultima Posición.
             IF nuIdx > 1 THEN tbCuponesPP.DELETE(tbCuponesPP.COUNT); END IF;
             CLOSE cuCuponSusPP;
        ELSIF ionuCupoNume IS NOT NULL THEN
               --Consulta Datos del Cupón 
               OPEN cuCuponNum (ionuCupoNume, csbCUPON_PAAN,'N');
             FETCH cuCuponNum INTO rcCuponNum;
             IF (cuCuponNum%FOUND) THEN
                  onuCupoValo := rcCuponNum.cupovalo;
                  osbCupoTipo := rcCuponNum.cupotipo;
                  osbCupoDocu := rcCuponNum.cupodocu;
                  ionuCupoNume := rcCuponNum.cuponume;
                  nuNumTraPp := nuNumTraPp + 1;
             END IF;
             CLOSE cuCuponNum;
        ELSE
               onuCupoValo := NULL;
        END IF;
        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.ValidarCuponPP',3);
        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidarCuponPP',3);
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidarCuponPP',3);
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidarCuponPP',3);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END ValidarCuponPP;
    
    ----------------------------------------------
    -- GetDataOut
    ----------------------------------------------
    PROCEDURE GetDataOut
    (
        ionuCupoNume   IN OUT    CUPON.CUPONUME%TYPE,
        ionuSuscCodi   IN OUT    SUSCRIPC.SUSCCODI%TYPE,
        osbCupoTipo    IN        CUPON.CUPOTIPO%TYPE,
        isbCupoDocu    IN        CUPON.CUPODOCU%TYPE,
        odtPefaFepa    OUT       PERIFACT.PEFAFEPA%TYPE,
        odtPefaFfpa    OUT       PERIFACT.PEFAFFPA%TYPE,
        onuFactCodi    OUT       FACTURA.FACTCODI%TYPE,
        ionuCupoValo   IN OUT NOCOPY   CUPON.CUPOVALO%TYPE,
        onuPefaDocu    OUT       PERIFACT.PEFACODI%TYPE,
        onuSaldoPend   OUT       CUENCOBR.CUCOSACU%TYPE
    )
    IS
       nuFactCodi      FACTURA.FACTCODI%TYPE;
       nuCucoCodi      CUENCOBR.CUCOCODI%TYPE;

       rcPeriFact      PERIFACT%ROWTYPE;
       nuPefaCodi      PERIFACT.PEFACODI%TYPE;
       nuSuscCodi      SUSCRIPC.SUSCCODI%TYPE;
       nuCupoNume      CUPON.CUPONUME%TYPE;

       dtFecha         PERIFACT.PEFAFEPA%TYPE;   -- Fecha Limite
       dtRecar         PERIFACT.PEFAFFPA%TYPE;   -- Fecha Limite Recargo
       nuAno           PERIFACT.PEFAANO%TYPE;    -- Ano Periodo
       nuMes           PERIFACT.PEFAMES%TYPE;    -- Mes Periodo
       dtPago          FECHVESU.FEVSFEVE%TYPE;   -- Fecha de Pago
       nuSaldoPend     CUENCOBR.CUCOSACU%TYPE;    -- Saldo Pendiente

     BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.GetDataOut');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetDataOut',3);
        
        -- <Com>Obtiene Informacion del Cupon para el Tipo.</Com>
        -- Valida Tipo de Cupon
        IF (osbCupoTipo IN (csbCUPON_FACT, csbCUPON_CUAG, csbCUPON_APFA)) THEN
            nuFactCodi := TO_NUMBER(isbCupoDocu);

            -- <Com>Cupon de Factura, Cuenta Agrupadora o Aplica Factura.</Com>
            -- Datos de Factura
            IF ( cuFactura%ISOPEN ) THEN
                CLOSE cuFactura;
            END IF;

            OPEN cuFactura (nuFactCodi);
            FETCH cuFactura INTO rcFactura;
            IF ( cuFactura%NOTFOUND ) THEN
                nuPefaCodi  := NULL;
            ELSE
                nuSuscCodi  := rcFactura.factsusc;
                nuPefaCodi  := rcFactura.factpefa;
                nuFactCodi  := rcFactura.factcodi;                
                nuSaldoPend := fnuValorCuponAnticipado(ionuCupoNume,pkBCAccountStatus.fnuGetBalance(rcFactura.factcodi));
            END IF;
            CLOSE cuFactura;

        ELSIF (osbCupoTipo = csbCUPON_CUCO) THEN
            nuCucoCodi := TO_NUMBER(isbCupoDocu);

            -- <Com>Cupon de Cuenta de Cobro.</Com>
            -- Datos de CuenCobr
            IF ( cuCuenCobr%ISOPEN ) THEN
                CLOSE cuCuenCobr;
            END IF;

            OPEN cuCuenCobr (nuCucoCodi);
            FETCH cuCuenCobr INTO rcCuenCobr;
            IF ( cuCuenCobr%NOTFOUND ) THEN
                nuPefaCodi  := NULL;
            ELSE
                nuSuscCodi  := rcCuencobr.factsusc;
                nuPefaCodi  := rcCuenCobr.factpefa;
                nuFactCodi  := rcCuenCobr.cucofact;
                nuSaldoPend := rcCuenCobr.cucosacu;
            END IF;
            CLOSE cuCuenCobr;
        ELSIF (osbCupoTipo = csbCUPON_PAAN) THEN
            nuCupoNume := ionuCupoNume;
             OPEN cuCuponNum (nuCupoNume, csbCUPON_PAAN,'N');
             FETCH cuCuponNum INTO rcCuponNum;
             IF (cuCuponNum%FOUND) THEN
                  nuSuscCodi  := rcCuponNum.cuposusc;
                  nuPefaCodi  := NULL;
                  nuFactCodi  := NULL;
                  dtPago :=SYSDATE;
                  dtRecar :=SYSDATE;                  
                  nuSaldoPend := rcCuponNum.cupovalo;
             END IF;
             CLOSE cuCuponNum;
        END IF;
        
        -- <Com>Valida si el Cupon es de la Suscripcion de Entrada</Com>
        IF (NVL(ionuSuscCodi, -1) != -1 AND NVL(ionuSuscCodi, -1) != nuSuscCodi) THEN
            -- <Men cod="EPM-BIL-10600">El cupon no pertenece a la suscripcion</Men>
            ionuCupoValo := NULL;
            pkErrors.setErrorCode (csbDivisionEPM,csbModuloBIL,cnuINVALID_CUPOSUS);
            RAISE LOGIN_DENIED;
        END IF;
        
        -- <Com>Obtiene Informacion para el Pago.</Com>
        IF (nuPefaCodi IS NOT NULL) THEN
            -- Asignacion de registro PERIFACT
            pkInstanceDataMgr.GetRecordBillingPeriod ( nuPefaCodi, rcPeriFact );
            dtFecha := rcPeriFact.pefafepa;
            dtRecar := rcPeriFact.pefaffpa;
            nuAno   := rcPeriFact.pefaano;
            nuMes   := rcPeriFact.pefames;

            -- Fecha de pago de la factura
            dtPago := NVL(pkSubsDateLineMgr.fdtGetDateLine (nuSuscCodi, nuAno, nuMes, dtFecha), dtFecha);
            IF (dtPago != dtFecha) THEN
                dtRecar := dtPago;
            END IF;
            nuCupoNume  := ionuCupoNume;
            
        ELSE
            IF ( osbCupoTipo NOT IN (csbCUPON_NEGO, csbCUPON_FINA, csbCUPON_PAAN)) THEN
                -- <Com>Valida si el Documento del Cupon es Valido</Com>
                -- <Men cod="EPM-BIL-10620">La factura y/o cuenta del cupon no existe</Men>
                ionuCupoValo := NULL;
                pkErrors.setErrorCode (csbDivisionEPM,csbModuloBIL,cnuINVALID_CUPODOC);
                RAISE LOGIN_DENIED;
            ELSE
                nuCupoNume  := ionuCupoNume;
                nuSuscCodi := pktblCupon.fnuGetCupoSusc(nuCupoNume);
                nuSaldoPend := pktblCupon.fnuGetCupoValo(nuCupoNume);
                nuFactCodi  := TO_NUMBER(pktblCupon.fsbGetCupoDocu(nuCupoNume));
            END IF;
        END IF;

        -- <Com>Asigna valores para las variables de salida</Com>
        odtPefaFepa := dtPago;
        odtPefaFfpa := dtRecar;
        ionuCupoNume := NVL(nuCupoNume, ionuCupoNume);
        ionuSuscCodi := nuSuscCodi;
        onuFactCodi := nuFactCodi;
        onuPefaDocu := nuPefaCodi;
        onuSaldoPend := nuSaldoPend;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetDataOut',3);
        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataOut',3);
            pkErrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataOut',3);
            pkErrors.Pop;
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataOut',3);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END GetDataOut;

    /******************************************************************************
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>ValidaConsulta</Unidad>
    <Descripcion>
    Valida la Consulta de Cupones para pago.
    </Descripcion>
    <Autor>Luis Fernando Cruz ( lcruzp ) Trebol Software S.A</Autor>
    <Fecha>20-Ago-2009</Fecha>
    <Parametros>
        <param nombre="ionuCupoNume" tipo="cupon.cuponume%TYPE" direccion="IN OUT">Numero del Cupon.</param>
        <param nombre="ionuSuscCodi" tipo="suscripc.susccodi%TYPE" direccion="IN OUT">Codigo de la Suscripcion.</param>
        <param nombre="inuFactRefe" tipo="factura.factcodi%TYPE" direccion="IN">Codigo de la factura de referencia.</param>
        <param nombre="onuCupoValo" tipo="cupon.cupovalo%TYPE" direccion="OUT">Valor del cupón.</param>
        <param nombre="odtPefaFepa" tipo="perifact.pefafepa%TYPE" direccion="OUT">Fecha de pago.</param>
        <param nombre="odtPefaFfpa" tipo="perifact.pefaffpa%TYPE" direccion="OUT">Fecha final de pago.</param>
        <param nombre="onuFactCodi" tipo="factura.factcodi%TYPE" direccion="OUT">Codigo de la factura.</param>
        <param nombre="onuCodigoError" tipo="pkg_epm_utilidades.tycodigoerror" direccion="OUT">Codigo del Error Presentado 0 si Exito.</param>
        <param nombre="osbMensajeError" tipo="pkg_epm_utilidades.tymensajeerror" direccion="OUT">Mensaje del Error reportado por el Aplicatvo.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="VJIMENEC" Fecha="06-May-2019" Inc="WO0000000143802">
         - Se modifica el método con el fin de incluir en el proceso de validación para obtener datos el cupón tipo PP.
        </Modificacion>
        
        <Modificacion Autor="rolartep" Fecha="25-Ago-2014" Inc="OC392747">
        - Se modifica el método pkg_Epm_WebCoupon.ValidaConsulta para eliminar la lógica de pagos
        - Se elimina el parámetro de salida onuPagoVapa debido a que el mismo, ya no es requerido para los procesos de validación.
        - Se modifica el método pkg_Epm_WebCoupon.ValidaConsulta para eliminar lógica de saldos
        </Modificacion>
    
        <Modificacion Autor="jpinedc" Fecha="28-Jul-2014" Inc="OC402523">
        * Se modifica GetDataOut para ejecutarla con el nuevo parametro de salida onuPefaDocu        
        * Se modifica para ejecutar pValidate_Periodos(ionuSuscCodi,onuPefaDocu)
        despues de ejecutat GetDataOut
        </Modificacion>

        <Modificacion Autor="lcruzp" Fecha="20-Ago-2009" Inc="OC61239">
        Creacion del Metodo.
        </Modificacion>
    </Historial>
    </Procedure>
    ******************************************************************************/
    PROCEDURE ValidaConsulta
    (
        ionuCupoNume       IN OUT   NUMBER,
        ionuSuscCodi       IN OUT   SUSCRIPC.SUSCCODI%TYPE,
        inuFactRefe        IN       FACTURA.FACTCODI%TYPE,
        onuCupoValo        OUT      CUPON.CUPOVALO%TYPE,
        odtPefaFepa        OUT      PERIFACT.PEFAFEPA%TYPE,
        odtPefaFfpa        OUT      PERIFACT.PEFAFFPA%TYPE,
        onuFactCodi        OUT      FACTURA.FACTCODI%TYPE,
        onuSaldoPend       OUT      CUENCOBR.CUCOSACU%TYPE,
        onuCodigoError     OUT      Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError    OUT      Pkg_Epm_Utilidades.tymensajeerror
    )
    IS
        -- Variables de Datos
        osbCupoTipo     CUPON.CUPOTIPO%TYPE;
        osbCupoDocu     CUPON.CUPODOCU%TYPE;
        onuPefaDocu     PERIFACT.PEFACODI%TYPE;        
        
        -- Comprobacion
        nuCupoValo      CUPON.CUPOVALO%TYPE;
        sbCupoTipo      CUPON.CUPOTIPO%TYPE;
        sbCupoDocu      CUPON.CUPODOCU%TYPE;

        blExiste        BOOLEAN := FALSE;
        blCupoFact      BOOLEAN := FALSE;
        blCupoCuco      BOOLEAN := FALSE;        
        blCupoPP      BOOLEAN := FALSE;        
        
        ----------------------------------------------
        -- Initialize
        ----------------------------------------------
        PROCEDURE Initialize
        (
            onuCodigoError   OUT  Pkg_Epm_Utilidades.TYCODIGOERROR,
            osbMensajeError  OUT  Pkg_Epm_Utilidades.TYMENSAJEERROR
        )
        IS
        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.ValidaConsulta.Initialize');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.ValidaConsulta.Initialize',4);
            -- Inicializa variables de Salida Fallo

            pkErrors.Initialize;
            onuCodigoError  := pkConstante.EXITO;
            osbMensajeError := pkConstante.NULLSB;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.ValidaConsulta.Initialize',4);
            pkErrors.Pop;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidaConsulta.Initialize',4);
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidaConsulta.Initialize',4);
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidaConsulta.Initialize',4);
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END Initialize;

    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.ValidaConsulta');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.ValidaConsulta',3);

        Initialize(onuCodigoError, osbMensajeError);

        -- <Com>Valida Cupon y Suscripcion de Entrada con Valores Nulos o -1</Com>
        IF ( NVL(ionuCupoNume, -1) = -1 AND NVL(ionuSuscCodi, -1) = -1 ) THEN
            -- <Men cod="EPM-BIL-10599">El cupon y la suscripcion no pueden ser nulos o -1</Men>
            pkErrors.setErrorCode (csbDivisionEPM, csbModuloBIL, cnuINVALID_PARAVAL);
            RAISE LOGIN_DENIED;
        END IF;
        
        --Valida si no se recibe cupón
        IF (NVL(ionuCupoNume, -1) != -1) THEN
            
            -- <Com>Valida con Cupon de Entrada.</Com>
            Validate_Cupon 
            (
                ionuCupoNume,
                ionuSuscCodi,
                onuCupoValo,
                osbCupoTipo,
                osbCupoDocu
            );
                        
            IF (onuCupoValo IS NULL) THEN
                -- <Men cod="OPF-SAT-1065">Cupon no Existe</Men>
                pkErrors.setErrorCode (csbDIVISION,csbMODULE,cnuINVALID_NOEXIST);
                RAISE LOGIN_DENIED;
            END IF;

        ELSIF ( NVL(ionuSuscCodi, -1) != -1 ) THEN

            -- --------------------------------------------------------------------------------------------
            -- La suscripción existe y tiene deuda pendiente. ok
            -- La obtención de los cupones se hace así:
            -- Buscar los cupones asociados a la factura del último periodo liquidado para la suscripción.
            -- Si existen varios cupon!es con el mismo valor, solo se devuelve el último.
            -- >>>> (Se Ajusta la Especificacion) En otro caso se devuelven todos los de diferente valor
            -- Valor agregado "Cupones por Tipo de Agrupacion" (No especificado)
            -- --------------------------------------------------------------------------------------------
            
            -- <Com>Valida con Suscriptor de Entrada.</Com>
            blExiste := pkTblSuscripc.fblExist (ionuSuscCodi, cnuNOCACHE);
            IF (NOT blExiste) THEN
                -- <Men cod="EPM-BIL-10050">Suscripcion no Existe</Men>
                pkErrors.setErrorCode (csbDivisionEPM,csbModuloBIL,cnuINVALID_NOSUSCR);
                RAISE LOGIN_DENIED;
            END IF;
            
            -- <Com>Obtiene Cupones para la Factura del Suscriptor.</Com>
            DBMS_OUTPUT.PUT_LINE('inuFactRefe: '||inuFactRefe);
            Validate_Suscr
            (
                ionuCupoNume,
                ionuSuscCodi,
                inuFactRefe,
                onuCupoValo,
                osbCupoTipo,
                osbCupoDocu
            );
            
            -- Confirma Existencia de Cupones para Factura
            IF (onuCupoValo IS NULL) THEN
                blCupoFact := FALSE;
                DBMS_OUTPUT.PUT_LINE('blCupoFact: FALSE');
            ELSE
                blCupoFact := TRUE;
                nuCupoValo := onuCupoValo;
                sbCupoTipo := osbCupoTipo;
                sbCupoDocu := osbCupoDocu;
            END IF;

            -- <Com>Obtiene Cupones para las Cuentas de la Factura del Suscriptor.</Com>
            onuCupoValo := NULL;
            osbCupoTipo := NULL;
            osbCupoDocu := NULL;

            Validate_Cuenta
            (
                ionuCupoNume,
                ionuSuscCodi,
                inuFactRefe,
                onuCupoValo,
                osbCupoTipo,
                osbCupoDocu
            );
              
            -- Confirma Existencia de Cupones de Cuenta para la Factura
            IF (onuCupoValo IS NULL) THEN
                blCupoCuco := FALSE;
                DBMS_OUTPUT.PUT_LINE('blCupoCuco: FALSE');
            ELSE
                blCupoCuco := TRUE;
            END IF;            
            
            -- <Com>Obtiene Cupones para Pago Anticipado.</Com>
            onuCupoValo := NULL;
            osbCupoTipo := NULL;
            osbCupoDocu := NULL;

            ValidarCuponPP
            (
                ionuCupoNume,
                ionuSuscCodi,
                onuCupoValo,
                osbCupoTipo,
                osbCupoDocu
            );

            -- Confirma Existencia de Cupones de Cuenta para la Factura
            IF (onuCupoValo IS NULL) THEN
                blCupoPP := FALSE;
                DBMS_OUTPUT.PUT_LINE('blCupoPP: FALSE');
            ELSE
                blCupoPP := TRUE;
            END IF;
            
            --Valida si se obtuvo algun tipo de cupón 
            IF (blCupoFact = FALSE AND blCupoCuco = FALSE AND blCupoPP = FALSE) THEN
                -- <Men cod="EPM-BIL-10601">No existen cupones para la ultima factura</Men>
                pkErrors.setErrorCode (csbDivisionEPM, csbModuloBIL, cnuINVALID_NOCUPON);
                RAISE LOGIN_DENIED;
            END IF;

            onuCupoValo := NVL(onuCupoValo, nuCupoValo);
            osbCupoTipo := NVL(osbCupoTipo, sbCupoTipo);
            osbCupoDocu := NVL(osbCupoDocu, sbCupoDocu);

        END IF;
        
        -- Tipos de Cupon: FA CA FI CC AF NG
        -- <Com>Recopilar Informacion de Salida.</Com>
        GetDataOut
        (
            ionuCupoNume,
            ionuSuscCodi,
            osbCupoTipo,
            osbCupoDocu,
            odtPefaFepa,
            odtPefaFfpa,
            onuFactCodi,
            onuCupoValo,
            onuPefaDocu,
            onuSaldoPend
        );

        -- Se valida que la cantidad de periodos trasncurridos no supere el dado
        -- por el parámetro EPM_PERVAL_WEBCUPON (6)
        -- No aplica para cupones de negociacion FI, NG, PP
        IF ( osbCupoTipo NOT IN (csbCUPON_NEGO, csbCUPON_FINA,csbCUPON_PAAN) ) THEN
            pValidate_Periodos(ionuSuscCodi, onuPefaDocu);
        END IF;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.ValidaConsulta',3);
        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidaConsulta',3);
            pkerrors.pop;
            pkerrors.geterrorvar (onuCodigoError, osbMensajeError);
        WHEN OTHERS THEN
            pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ValidaConsulta',3);
            pkerrors.pop;
            RAISE_APPLICATION_ERROR (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END ValidaConsulta;

    /*
      <Oref Nombre="pkg_Epm_WebCoupon" Tipo="PAQUETE" Own="FLEX_CUSTOMIZACION">Package que contiene el API para Obtener el valor a Pagar de un Cupon de Pago</Oref>
      <Oref Nombre="pkInstanceDataMgr" Tipo="PAQUETE" Own="FLEX">Paquete para Instanciar Datos Generales</Oref>
      <Oref Nombre="pkSubsDateLineMgr" Tipo="PAQUETE" Own="FLEX">Paquete para Instanciar Datos Fechas de Pago</Oref>
      <Oref Nombre="pkg_epm_queryperiodicidad" Tipo="PAQUETE" Own="FLEX_CUSTOMIZACION">Paquete para Instanciar Datos Periodicidad de lectura</Oref>
      <Oref Nombre="EPM_WEBCUPON" Tipo="TABLA" Own="FLEX">Tabla de Cupones WEB</Oref>
      <Oref Nombre="CUPON" Tipo="TABLA" Own="FLEX">Tabla de Cupones Generados</Oref>
      <Oref Nombre="SUSCRIPC" Tipo="TABLA" Own="FLEX">Tabla de Suscriptores</Oref>
      <Oref Nombre="PAGOS" Tipo="TABLA" Own="FLEX">Tabla de Pagos</Oref>
      <Oref Nombre="FACTURA" Tipo="TABLA" Own="FLEX">Tabla de Facturas</Oref>
      <Oref Nombre="PERIFACT" Tipo="TABLA" Own="FLEX">Tabla de Periodos</Oref>
      <Oref Nombre="FECHVESU" Tipo="TABLA" Own="FLEX">Tabla de Fechas Vencimiento</Oref>
      <Oref Nombre="PR_PRODUCT" Tipo="TABLA" Own="FLEX">Tabla OSS Productos</Oref>
      <Oref Nombre="MO_MOTIVE" Tipo="TABLA" Own="FLEX">Tabla OSS Motivos</Oref>
      <Oref Nombre="MO_PACKAGES" Tipo="TABLA" Own="FLEX">Tabla OSS Solicitudes</Oref>
      <Oref Nombre="CC_FINANCING_REQUEST" Tipo="TABLA" Own="FLEX">Tabla OSS Solicitud de Financiacion</Oref>
      <Oref Nombre="AB_ADDRESS" Tipo="TABLA" Own="FLEX">Tabla OSS de Direcciones</Oref>
      <Oref Nombre="GST_PAIS" Tipo="TABLA" Own="FLEX">Tabla de paises</Oref>
    */
    ----------------------------------------------
    -- GetDataCupon
    ----------------------------------------------
    /*
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>GetDataCupon</Unidad>
    <Descripcion>
    API para consultar los cupones de pago de suscripcion.
    </Descripcion>
    <Autor>Luis Fernando Cruz ( lcruzp ) Trebol Software S.A</Autor>
    <Fecha>20-Ago-2009</Fecha>
    <Parametros>
        <param nombre="inuCupoNume" tipo="NUMBER" direccion="IN">Numero del Cupon.</param>
        <param nombre="inuSuscCodi" tipo="suscripc.susccodi%TYPE" direccion="IN">Codigo del Suscriptor.</param>
        <param nombre="orcRecordSet" tipo="SYS_REFCURSOR" direccion="OUT">Cursor referenciado que contiene los datos de cupon para pago.</param>
        <param nombre="onuCodigoError" tipo="pkg_epm_utilidades.tycodigoerror" direccion="OUT">Codigo del Error Presentado 0 Exito.</param>
        <param nombre="osbMensajeError" tipo="pkg_epm_utilidades.tymensajeerror" direccion="OUT">Mensaje del error reportado por el aplicatvo.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="DHURTADP" Fecha="21-02-2020" Inc="WO0000000478243">
            Se modifica el método (Consultar) el cursor orcRecordSet para reemplazar el split por instr.
        </Modificacion>
        <Modificacion Autor="jpinedc" Fecha="28-Jul-2014" Inc="OC402523">
        Se modifica para evaluar la ejecución de ValidaConsulta:
        * Si retorna error se devuelve un cursor nulo ( ejecutando el método openCursorNull)
        * Si no retorna error se evalua si se ejecta el método Consultar
        </Modificacion>

        <Modificacion Autor="aruedap" Fecha="08-Jun-2010" Inc="OC102424">
        Se modifica la definición del tipo de dato del parámetro de entrada "inuCupoNume":
        * Se cambio "cupon.cuponume%TYPE" por "NUMBER" ya que puede recibir
          un valor de mayor tamaño que el campo CUPONUME de la tabla CUPON
          por la adición de los digitos de chequeo.

        Se invoca el método Pkg_Epm_Recaudo_OnLine.prSplitValidateCoupon que
        se encarga de separar los digitos de chequeo del número del cupón, y
        valida que los digitos de chequeo ingresados correspondan al número
        del cupón.

        Se ajusta el submétodo "Consultar" para que retorne en el cursor
        referenciado el número de cupón concatenado con los digitos de
        chequeo.
        </Modificacion>

        <Modificacion Autor="lfcruz" Fecha="20-Ago-2009" Inc="OC61239">
        Creación del Método.
        </Modificacion>
    </Historial>
    </Procedure>
    */
    PROCEDURE GetDataCupon
    (
        inuCupoNume      IN   NUMBER,
        inuSuscCodi      IN   SUSCRIPC.SUSCCODI%TYPE,
        orcRecordSet     OUT  SYS_REFCURSOR,
        onuCodigoError   OUT  Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError  OUT  Pkg_Epm_Utilidades.tymensajeerror
    )
    IS
        -- Variables Campos de Salida
        ionuCupoNume          NUMBER; -- CUPON.CUPONUME%TYPE;
        ionuDigCheck          NUMBER;
        ionuSuscCodi          SUSCRIPC.SUSCCODI%TYPE;
        onuCupoValo           CUPON.CUPOVALO%TYPE;
        onuPagoVapa           PAGOS.PAGOVAPA%TYPE;
        odtPefaFepa           PERIFACT.PEFAFEPA%TYPE;
        odtPefaFfpa           PERIFACT.PEFAFFPA%TYPE;
        onuFactCodi           FACTURA.FACTCODI%TYPE;
        onuSaldoPend          CUENCOBR.CUCOSACU%TYPE;

        -- Cursor Salida
        TYPE tyRecordSet      IS REF CURSOR;
        rcRecordSet           tyRecordSet;

        blFactInte          BOOLEAN;
        nuContInte          NUMBER;
        nuFacturaAct        FACTURA.FACTCODI%TYPE;
        nuPeriFactAct       FACTURA.FACTPEFA%TYPE;
        nuError             Pkg_Epm_Utilidades.tycodigoerror;
        ----------------------------------------------
        -- Initialize
        ----------------------------------------------
        PROCEDURE Initialize
        (
            onuCodigoError   OUT  Pkg_Epm_Utilidades.TYCODIGOERROR,
            osbMensajeError  OUT  Pkg_Epm_Utilidades.TYMENSAJEERROR
        )
        IS
        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.Initialize');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetDataCupon.Initialize',4);

            -- Inicializa variables de Salida Fallo
            pkErrors.Initialize;

            onuCodigoError  := pkConstante.EXITO;
            osbMensajeError := pkConstante.NULLSB;

            cnuMAX_NUMERO_PERIODOS := pkg_EPM_BOParametr.fnuGet('EPM_PERVAL_WEBCUPON');

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetDataCupon.Initialize',4);
            pkErrors.Pop;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.Initialize',4);
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.Initialize',4);
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.Initialize',4);
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END Initialize;
        ----------------------------------------------
        -- ClearMemory
        ----------------------------------------------
        PROCEDURE ClearMemory
        IS
        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.ClearMemory');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetDataCupon.ClearMemory',4);

            -- Inicializa Memoria Cache
            pkTblCupon.ClearMemory;
            pkTblPeriFact.ClearMemory;
            pkTblSuscripc.ClearMemory;
            pkTblFactura.ClearMemory;
            pkTblCuencobr.ClearMemory;

            -- Indicadores Consulta
            nuNumTrans := 0;
            nuNumTraCc := 0;
            nuNumTraPp := 0;
            
            --Inicializa
            tbCuponesPP := tbCuponesPPEmpty;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetDataCupon.ClearMemory',4);
            pkErrors.Pop;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.ClearMemory',4);
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.ClearMemory',4);
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.ClearMemory',4);
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END ClearMemory;
        ----------------------------------------------
        -- Consultar
        ----------------------------------------------
        PROCEDURE Consultar
        (
            inuCupoNume   IN  NUMBER,
            inuSuscCodi   IN  SUSCRIPC.SUSCCODI%TYPE,
            inuCupoValo   IN  CUPON.CUPOVALO%TYPE,
            idtPefaFepa   IN  PERIFACT.PEFAFEPA%TYPE,
            idtPefaFfpa   IN  PERIFACT.PEFAFFPA%TYPE,
            inuFactCodi   IN  FACTURA.FACTCODI%TYPE,
            inuSaldoPend  IN  CUENCOBR.CUCOSACU%TYPE,
            orcRecordSet  OUT NOCOPY SYS_REFCURSOR
        )
        IS
            sbTipo        CUPON.CUPOTIPO%TYPE;      -- Tipo de cupon
            dtPago        FECHVESU.FEVSFEVE%TYPE;   -- Fecha de Pago
            dtRecar       PERIFACT.PEFAFFPA%TYPE;   -- Fecha Limite Recargo
        BEGIN

            pkErrors.Push('pkg_Epm_WebCoupon.GetDataCupon.Consultar');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetDataCupon.Consultar',4);

            -- <Com>Seleccion que Recupera los Cupones para pago.</Com>
            -- <Com>Cierra Cursor Referencia.</Com>
            IF (orcRecordSet%ISOPEN) THEN
                CLOSE orcRecordSet;
            END IF;
            
            -- <Com>Volca todos los Datos de la Seleccion de Consulta.</Com>
            IF (nuNumTraPp = 1 AND inuCupoNume != -1) THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('(nuNumTraPp = 1 AND inuCupoNume != -1)', 5);
                sbTipo := pktblCupon.fsbGetCupoTipo(inuCupoNume);
                dtPago := idtPefaFepa;
                dtRecar := idtPefaFfpa;
                
                -- Consulta Cupon
                OPEN orcRecordSet FOR
                SELECT inuCupoNume||LPAD(fnuGetDigitoChequeo(inuCupoNume), 2, 0) cuponume, 
                       inuSuscCodi, inuFactCodi, inuCupoValo, dtPago idtPefaFepa, dtRecar idtPefaFfpa, 
                       DECODE (fsbGetPagado(inuCupoNume), 'S', 0, inuSaldoPend) saldo,
                       sbTipo cupotipo
                 FROM DUAL;
            ELSIF (nuNumTraPp >= 1 AND inuCupoNume != -1) THEN               
                 Pkg_Epm_Utilidades.Trace_SetMsg('(nuNumTraPp > 1 AND inuCupoNume != -1)', 5);
                 sbTipo := pktblCupon.fsbGetCupoTipo(inuCupoNume);
                 dtPago := idtPefaFepa;
                 dtRecar := idtPefaFfpa;
                 
                 -- Consulta Cupones
                 OPEN orcRecordSet FOR
                SELECT cuponume||LPAD(fnuGetDigitoChequeo(cuponume), 2, 0) cuponume, 
                       cuposusc inuSuscCodi, cupodocu inuFactCodi, cupovalo inuCupoValo, dtPago idtPefaFepa, dtRecar idtPefaFfpa, 
                       DECODE (fsbGetPagado(cuponume), 'S', 0, cupovalo) saldo,
                       cupotipo cupotipo
                 FROM cupon
                 WHERE cuponume IN (SELECT nuCampo01 FROM TABLE(CAST(tbCuponesPP AS epm_tyGeneral)));
            ELSIF ((nuNumTrans = 1 OR nuNumTraPp = 1) AND nuNumTraCc = 0 AND inuCupoNume != -1) THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('nuNumTrans = 1 AND nuNumTraCc = 0 AND inuCupoNume != -1', 5);

                sbTipo := pktblCupon.fsbGetCupoTipo(inuCupoNume);
                dtPago := idtPefaFepa;
                dtRecar := idtPefaFfpa;

                IF ( sbTipo IN (csbCUPON_FINA, csbCUPON_NEGO) ) THEN
                    dtPago  := TRUNC(DACC_financing_request.fdtGetRecord_Date(inuFactCodi));
                    dtRecar := pkHoliDayMgr.fdtGetDateNonHoliDay (dtPago, cnuBIL_MAX_DIAS_ESPER_F);
                END IF;

                -- Consulta Cupon
                OPEN orcRecordSet FOR
                SELECT inuCupoNume||LPAD(fnuGetDigitoChequeo(inuCupoNume), 2, 0) cuponume, 
                       inuSuscCodi, inuFactCodi, inuCupoValo, dtPago idtPefaFepa, dtRecar idtPefaFfpa, 
                       DECODE (fsbGetPagado(inuCupoNume), 'S', 0, inuSaldoPend) saldo,
                       sbTipo cupotipo
                  FROM DUAL;

            ELSIF (nuNumTrans > 1 AND nuNumTraCc = 0) THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('nuNumTrans > 1 AND nuNumTraCc = 0',5);
                
                -- Consulta Suscriptor Factura
                OPEN orcRecordSet FOR
                WITH cupones as
                (
                  SELECT MAX(cuponume) cuponume,
                         inuSuscCodi SuscCodi, cupodocu FactCodi, cupovalo, idtPefaFepa PefaFepa, idtPefaFfpa PefaFfpa,
                         NVL(pkBCAccountStatus.fnuGetBalance(factcodi), 0) saldo
                    FROM cupon, factura
                   WHERE cupodocu IN (SELECT sbCampo01 FROM TABLE(CAST(tbFacturas AS epm_tyGeneral)))
                     AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||',',','||cupotipo||',') = 0
                     AND cupovalo > 0
                     AND cupocupa IS NULL
                     AND TO_NUMBER(cupodocu) = factcodi
                     AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER(NVL(cupoprog, '-'))||',') = 0                     
                   GROUP BY cupodocu, cupovalo, NVL(pkBCAccountStatus.fnuGetBalance(factcodi), 0)
                 )
                SELECT TO_CHAR(cupon.cuponume)||LPAD(fnuGetDigitoChequeo(cupon.cuponume), 2, 0),
                       Cupones.SuscCodi, Cupones.FactCodi, Cupon.cupovalo, Cupones.PefaFepa, Cupones.PefaFfpa, 
                       DECODE (fsbGetPagado(cupon.cuponume), 'S', 0, 'X', -1, fnuValorCuponAnticipado(cupon.cuponume, Cupones.saldo)) saldo,
                       cupon.cupotipo
                  FROM cupones, cupon
                 WHERE cupones.cuponume = cupon.cupocupa
                 UNION
                SELECT cupones.cuponume||LPAD(fnuGetDigitoChequeo(cupones.cuponume), 2, 0),
                       Cupones.SuscCodi, Cupones.FactCodi, Cupones.cupovalo, Cupones.PefaFepa, Cupones.PefaFfpa,
                       DECODE(fnuValorCuponAnticipado(cupones.cuponume, Cupones.saldo), 0, 0, 
                       DECODE (fsbGetPagado(cupones.cuponume), 'S', 0, 'X', -1, fnuValorCuponAnticipado(cupones.cuponume, Cupones.saldo))) saldo,
                       pktblCupon.fsbGetCupoTipo(cupones.cuponume) cupotipo
                  FROM cupones
                 ORDER BY 1 DESC;
            ELSE
                Pkg_Epm_Utilidades.Trace_SetMsg(' ELSE ',5);

                -- Consulta Suscriptor Factura mas Cuentas de Factura
                OPEN orcRecordSet FOR
                SELECT cupones.* FROM
                (
                  SELECT MAX(cuponume)||LPAD(fnuGetDigitoChequeo(MAX(cuponume)), 2, 0) cuponume,
                         inuSuscCodi, inuFactCodi, cupovalo, idtPefaFepa, idtPefaFfpa, 
                         DECODE (fsbGetPagado(cuponume), 'S', 0, 'X', -1, NVL(cucosacu, 0)) saldo,
                         cupotipo
                    FROM cupon, cuencobr
                   WHERE cupodocu = TO_CHAR(inuFactCodi)
                     AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||',',','||cupotipo||',') = 0
                     AND cupovalo > 0
                     AND cupocupa IS NULL
                     AND TO_NUMBER(cupodocu) = cucocodi
                     AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER(NVL(cupoprog, '-'))||',') = 0                        
                   GROUP BY cupovalo, DECODE (fsbGetPagado(cuponume), 'S', 0, 'X', -1, NVL(cucosacu, 0)), cupotipo
                 ) cupones, cupon
                 WHERE cupones.cuponume = cupon.cupocupa
                 UNION ALL
                 SELECT cupones.* FROM
                 (
                   SELECT MAX(cuponume)||LPAD(fnuGetDigitoChequeo(MAX(cuponume)), 2, 0) cuponume,
                          inuSuscCodi, inuFactCodi, cupovalo, idtPefaFepa, idtPefaFfpa, 
                          DECODE (fsbGetPagado(cuponume), 'S', 0, 'X', -1, NVL(DATA_CUCO.cucosacu, 0)) saldo,
                          cupotipo
                     FROM cupon, (
                                   SELECT cucocodi, cucosacu
                                     FROM cuencobr
                                    WHERE cucocodi = inuFactCodi
                                 ) DATA_CUCO
                    WHERE cupodocu = TO_CHAR(DATA_CUCO.cucocodi)
                      AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||', FA,CA'||',',','||cupotipo||',') = 0
                      AND cupovalo > 0
                      AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER(NVL(cupoprog, '-'))||',') = 0
                    GROUP BY cupovalo, DECODE (fsbGetPagado(cuponume), 'S', 0, 'X', -1, NVL(DATA_CUCO.cucosacu, 0)), cupotipo
                 ) cupones, cupon
                 WHERE cupones.cuponume = cupon.cupocupa
                 UNION ALL
                 SELECT MAX(cuponume)||LPAD(fnuGetDigitoChequeo(MAX(cuponume)), 2, 0) cuponume,
                        inuSuscCodi, inuFactCodi, cupovalo, idtPefaFepa, idtPefaFfpa, DECODE (fsbGetPagado(cuponume), 'S', 0, 'X', -1, NVL(cucosacu, 0)) saldo,
                        cupotipo
                   FROM cupon, cuencobr
                  WHERE cupodocu = TO_CHAR(inuFactCodi)
                    AND instr(','||csbEPM_TIPOCUPO_EXCLWEB||',',','||cupotipo||',') = 0
                    AND cupovalo > 0
                    AND TO_NUMBER(cupodocu) = cucocodi
                    AND instr(','||csbEPM_CUPOPROG_EXCLWEB||',',','||UPPER(NVL(cupoprog, '-'))||',') = 0
                  GROUP BY cupovalo, DECODE (fsbGetPagado(cuponume), 'S', 0, 'X', -1, NVL(cucosacu, 0)), cupotipo
                  ORDER BY 1 DESC;
            END IF;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetDataCupon.Consultar',4);
            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.Consultar',4);
                Pkerrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN Pkconstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.Consultar',4);
                Pkerrors.Pop;
                RAISE Pkconstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                Pkerrors.NotifyError( Pkerrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.Consultar',4);
                Pkerrors.Pop;
                RAISE_APPLICATION_ERROR( Pkconstante.nuERROR_LEVEL2, sbErrMsg );
        END Consultar;
        
        ----------------------------------------------
        -- ConsultarFI
        ----------------------------------------------
        PROCEDURE ConsultarFI
        (
            inuCupoNume   IN  NUMBER,
            inuSuscCodi   IN  SUSCRIPC.SUSCCODI%TYPE,
            inuCupoValo   IN  CUPON.CUPOVALO%TYPE,
            idtPefaFepa   IN  PERIFACT.PEFAFEPA%TYPE,
            idtPefaFfpa   IN  PERIFACT.PEFAFFPA%TYPE,
            inuFactCodi   IN  FACTURA.FACTCODI%TYPE,
            inuSaldoPend  IN  CUENCOBR.CUCOSACU%TYPE,
            orcRecordSet  OUT NOCOPY SYS_REFCURSOR
        )
        IS
            dtPago        FECHVESU.FEVSFEVE%TYPE;   -- Fecha de Pago
            dtRecar       PERIFACT.PEFAFFPA%TYPE;   -- Fecha Limite Recargo
        BEGIN

            pkErrors.Push('pkg_Epm_WebCoupon.GetDataCupon.ConsultarFI');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetDataCupon.ConsultarFI',4);
            
            -- <Com>Seleccion que Recupera los Cupones para pago.</Com>
            -- <Com>Cierra Cursor Referencia.</Com>
            IF (orcRecordSet%ISOPEN) THEN
                CLOSE orcRecordSet;
            END IF;

            -- <Com>Volca todos los Datos de la Seleccion de Consulta.</Com>
            -- <Com>Consulta cupón de financiación.</Com>
            IF ( cuFinancia%ISOPEN ) THEN
                CLOSE cuFinancia;
            END IF;

            rcFinancia := NULL;
            OPEN cuFinancia (inuSuscCodi);
            FETCH cuFinancia INTO rcFinancia;

            DBMS_OUTPUT.PUT_LINE ('Fecha Solicitud: '||TO_CHAR(rcFinancia.record_date, 'DD-MM-YYYY'));

            IF ( cuFinancia%NOTFOUND OR pkHoliDayMgr.fdtGetDateNonHoliDay (rcFinancia.record_date, cnuBIL_MAX_DIAS_ESPER_F) < SYSDATE ) THEN
                NULL;
                DBMS_OUTPUT.PUT_LINE ('--> No hay cupon de negociacion disponible');
                openCursorNull (orcRecordSet);
            ELSE

                rcCuponDoc := NULL; 
                OPEN  cuCuponDoc ( TO_CHAR(rcFinancia.financing_request_id) );
                FETCH cuCuponDoc INTO rcCuponDoc;
                CLOSE cuCuponDoc;

                dtPago  := TRUNC(rcFinancia.record_date);
                dtRecar := pkHoliDayMgr.fdtGetDateNonHoliDay (dtPago, cnuBIL_MAX_DIAS_ESPER_F);
                DBMS_OUTPUT.PUT_LINE ('Cupon: '||rcCuponDoc.cuponume);
                DBMS_OUTPUT.PUT_LINE ('Fecha Vence: '||TO_CHAR(dtRecar, 'DD-MM-YYYY'));
                
                -- Consulta del cupón
                OPEN orcRecordSet FOR
                SELECT cuponume||LPAD(fnuGetDigitoChequeo(cuponume), 2, 0) cuponume,
                       inuSuscCodi, cupodocu, cupovalo, dtPago idtPefaFepa, dtRecar idtPefaFfpa, cupovalo saldo,
                       cupotipo
                  FROM cupon
                 WHERE cuponume = rcCuponDoc.cuponume
                   AND cupotipo = rcCuponDoc.cupotipo
                   AND NOT EXISTS
                   (
                       SELECT pagocupo
                         FROM pagos
                        WHERE pagocupo = rcCuponDoc.cuponume
                   )
                   AND cupovalo > 0
                 ORDER BY cuponume DESC;

            END IF;
            CLOSE cuFinancia;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetDataCupon.ConsultarFI',4);
            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.ConsultarFI',4);
                Pkerrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN Pkconstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.ConsultarFI',4);
                Pkerrors.Pop;
                RAISE Pkconstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                Pkerrors.NotifyError( Pkerrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon.ConsultarFI',4);
                Pkerrors.Pop;
                RAISE_APPLICATION_ERROR( Pkconstante.nuERROR_LEVEL2, sbErrMsg );
        END ConsultarFI;

    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.GetDataCupon');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetDataCupon',3);

        -- Se inicializa la tabla PL de volcado para cursor ref de salida
        gtbGeneral := gtbGeneral_Empty;
        nuIndiceIn := 0;

        /*
        Numero del cupon
        Numero de la suscripcion (Contrato)
        Numero de Factura
        Valor cupon
        Fecha de vencimiento
        Fecha de vencimiento con recargo
        Saldo
        Tipo de cupon
        */
        -- <Com>Limpia Fallo.</Com>
        Initialize (onuCodigoError, osbMensajeError);
        -- <Com>Limpia Memoria Cache.</Com>
        ClearMemory;

        -- <Com>Obtiene Datos con Parametros de Entrada</Com>
        IF (NVL(inuCupoNume, -1) = -1) THEN
            ionuCupoNume := inuCupoNume;
        ELSE
            Pkg_Epm_Recaudo_Online.prSplitValidateCoupon (inuCupoNume, ionuCupoNume, ionuDigCheck);
        END IF;
        
        ionuSuscCodi := inuSuscCodi;
        pkg_epm_queryperiodicidad.GetDatosLect(ionuSuscCodi, gnuFrecLect);
        
        -- <Com>Valida Datos de Consulta.</Com>
        ValidaConsulta 
        (
           ionuCupoNume,
           ionuSuscCodi,
           NULL,
           onuCupoValo,
           odtPefaFepa,
           odtPefaFfpa,
           onuFactCodi,
           onuSaldoPend,
           onuCodigoError,
           osbMensajeError
        );
        
        --Valida Retorno Exitoso
        IF ( NVL(onuCodigoError, 0) = pkConstante.Exito ) THEN

            -- <Com>Obtiene Cursor con Datos de Salida</Com>
            IF (nuNumTrans > 0 OR nuNumTraCc > 0 or nuNumTraPp > 0) THEN
                
                Consultar
                (
                    ionuCupoNume, ionuSuscCodi, onuCupoValo,
                    odtPefaFepa, odtPefaFfpa, onuFactCodi, onuSaldoPend,
                    rcRecordSet
                );

                -- Colecciona los resultados de la consulta
                ColecConsulta (rcRecordSet, nuIndiceIn, nuIndiceOut, onuCodigoError, osbMensajeError);
                nuIndiceIn := nuIndiceOut;

                IF (gnuFrecLect > 1) THEN

                    nuContInte := 0;
                    WHILE TRUE LOOP

                        nuFacturaAct := onuFactCodi;
                        nuPeriFactAct := pktblFactura.fnuGetFactPefa(nuFacturaAct);
                        pkg_epm_queryperiodicidad.ValidaFactura (ionuSuscCodi, nuPeriFactAct, blFactInte);
                        DBMS_OUTPUT.PUT_LINE('nuFacturaAct: '||nuFacturaAct);
                        ionuCupoNume := inuCupoNume;

                        IF (blFactInte) THEN
                            DBMS_OUTPUT.PUT_LINE('Es intermedia: '||nuFacturaAct||' - '||ionuCupoNume);
                            
                            nuContInte := nuContInte + 1;
                    
                            IF (nuContInte > gnuFrecLect - 1) THEN
                                DBMS_OUTPUT.PUT_LINE('nuContInte: '||nuContInte);
                                EXIT;
                            END IF;

                            -- <Com>Valida Datos de Consulta.</Com>
                            ValidaConsulta
                            (
                               ionuCupoNume,
                               ionuSuscCodi,
                               nuFacturaAct,
                               onuCupoValo,
                               odtPefaFepa,
                               odtPefaFfpa,
                               onuFactCodi,
                               onuSaldoPend,
                               onuCodigoError,
                               osbMensajeError
                            );

                            DBMS_OUTPUT.PUT_LINE('Es intermedia: '||onuFactCodi||' - '||ionuCupoNume);
                            nuError := onuCodigoError;
                            -- <Com>Obtiene Cursor con Datos de Salida</Com>
                            IF (nuNumTrans > 0 OR nuNumTraCc > 0) THEN
                
                                Consultar
                                (
                                    ionuCupoNume, ionuSuscCodi, onuCupoValo,
                                    odtPefaFepa, odtPefaFfpa, onuFactCodi, onuSaldoPend,
                                    rcRecordSet
                                );

                                -- Colecciona los resultados de la consulta
                                ColecConsulta (rcRecordSet, nuIndiceIn, nuIndiceOut, onuCodigoError, osbMensajeError);
                                nuIndiceIn := nuIndiceOut;
    
                            END IF;
                            
                        ELSE
                            EXIT;
                        END IF; -- Es intermedia
                    
                    END LOOP;

                END IF;

            ELSE
                -- Es por que nuNumTrans > 0 OR nuNumTraCc > 0 no se dio
                IF (gnuFrecLect > 1) THEN

                    onuFactCodi := gnuFactCodi;
                    nuContInte := 0;
                    WHILE TRUE LOOP

                        nuFacturaAct := onuFactCodi;
                        nuPeriFactAct := pktblFactura.fnuGetFactPefa(nuFacturaAct);
                        pkg_epm_queryperiodicidad.ValidaFactura (ionuSuscCodi, nuPeriFactAct, blFactInte);
                        DBMS_OUTPUT.PUT_LINE('nuFacturaAct: '||nuFacturaAct);
                        ionuCupoNume := inuCupoNume;
    
                        IF (blFactInte) THEN
                            DBMS_OUTPUT.PUT_LINE('Es intermedia: '||nuFacturaAct||' - '||ionuCupoNume);

                            nuContInte := nuContInte + 1;

                            IF (nuContInte > gnuFrecLect - 1) THEN
                                DBMS_OUTPUT.PUT_LINE('nuContInte: '||nuContInte);
                                EXIT;
                            END IF;

                            -- <Com>Valida Datos de Consulta.</Com>
                            ValidaConsulta
                            (
                               ionuCupoNume,
                               ionuSuscCodi,
                               nuFacturaAct,
                               onuCupoValo,                         
                               odtPefaFepa,
                               odtPefaFfpa,
                               onuFactCodi,
                               onuSaldoPend,
                               onuCodigoError,
                               osbMensajeError
                            );

                            DBMS_OUTPUT.PUT_LINE('Es intermedia: '||onuFactCodi||' - '||ionuCupoNume);
                            nuError := onuCodigoError;
                            -- <Com>Obtiene Cursor con Datos de Salida</Com>
                            IF (nuNumTrans > 0 OR nuNumTraCc > 0) THEN
                
                                Consultar
                                (
                                    ionuCupoNume, ionuSuscCodi, onuCupoValo,
                                    odtPefaFepa, odtPefaFfpa, onuFactCodi, onuSaldoPend,
                                    rcRecordSet
                                );
                
                                -- Colecciona los resultados de la consulta
                                ColecConsulta (rcRecordSet, nuIndiceIn, nuIndiceOut, onuCodigoError, osbMensajeError);
                                nuIndiceIn := nuIndiceOut;
    
                            END IF;
                            
                        ELSE
                            EXIT;
                        END IF; -- Es intermedia
                    
                    END LOOP;
                ELSE
                    -- Frecuencia de lectura es mensual
                    -- No se debe hacer nada (No se omite del codigo para mayor claridad y futuros cambios)
                    NULL;
                END IF;

            END IF;

        ELSE
            -- Es por que fallo ValidaConsulta con error retornado
            nuError := onuCodigoError;
            NULL;
        END IF;

        -- <Com>Obtiene cupones de Negociacion</Com>        
        ionuCupoNume := inuCupoNume;
        IF (NVL(ionuCupoNume, -1) = -1) THEN
            ConsultarFI
            (
                ionuCupoNume, 
                ionuSuscCodi, 
                onuCupoValo,
                odtPefaFepa, 
                odtPefaFfpa, 
                onuFactCodi, 
                onuSaldoPend,
                rcRecordSet
            );

            -- Colecciona los resultados de la consulta
            ColecConsulta (rcRecordSet, nuIndiceIn, nuIndiceOut, onuCodigoError, osbMensajeError);
            nuIndiceIn := nuIndiceOut;
        END IF;

        -- <Com>Asigna Registro de Datos de Salida</Com>
        gtbGeneral.DELETE(gtbGeneral.COUNT);

        IF (gtbGeneral.COUNT > 0) THEN
            -- Encontro cupones validos para recaudo
            OPEN rcRecordSet FOR
            SELECT nuCampo01     NumeroCupon,
                   nuCampo02     Contrato,
                   nuCampo03     CodigoFactura,
                   nuCampo04     ValorCupon,
                   TRUNC(dtCampo01)     FechaPago,
                   TRUNC(dtCampo02)     FinalPago,
                   ROUND(nuCampo05)     Saldo,
                   sbCampo01     TipoCupon
              FROM TABLE(CAST(gtbGeneral AS epm_tyGeneral))
             WHERE ROUND(nuCampo05) > -1 
             GROUP BY nuCampo01, nuCampo02, nuCampo03, nuCampo04, dtCampo01, dtCampo02, nuCampo05, sbCampo08, sbCampo01
             ORDER BY nuCampo03 DESC, nuCampo01;

        ELSE
            DBMS_OUTPUT.PUT_LINE('pkg_Epm_WebCoupon.GetDataCupon.OpenCursorNull (rcRecordSet)');
            pkg_epm_utilidades.EvaluarError(nuError);
        END IF;

        orcRecordSet := rcRecordSet;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetDataCupon',3);
        pkErrors.pop;

    EXCEPTION
        WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon',3);
            pkErrors.Pop;
            pkErrors.GetErrorVar (onuCodigoError, osbMensajeError);
            openCursorNull (orcRecordSet);
        WHEN OTHERS THEN
            pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetDataCupon',3);
            pkErrors.Pop;
            openCursorNull (orcRecordSet);
            RAISE_APPLICATION_ERROR (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END GetDataCupon;

    ----------------------------------------------
    -- fnuGetDigitoChequeo
    ----------------------------------------------
    /*
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>fnuGetDigitoChequeo</Unidad>
    <Descripcion>
    Retorna los digitos de chequeo correspondiente a un cupón.
    </Descripcion>
    <Autor>Andrés Alberto Rueda Patiño ( aruedap ) Trebol Software S.A</Autor>
    <Fecha>10-Jun-2010</Fecha>
    <Retorno Nombre = "nuDigCheck" Tipo = "NUMBER">
    Digitos de chequeo.
    </Retorno>
    <Parametros>
        <param nombre="inuCupoNume" tipo="cupon.cuponume%TYPE" direccion="IN">Numero del Cupon.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="aruedap" Fecha="10-Jun-2010" Inc="OC102424">
        Creación del Método.
        </Modificacion>
    </Historial>
    </Procedure>
    */
    FUNCTION fnuGetDigitoChequeo
    (
        inuCupoNume  IN  CUPON.CUPONUME%TYPE
    )
    RETURN NUMBER
    IS
        nuDigCheck  NUMBER;
    BEGIN
        pkErrors.push('pkg_Epm_WebCoupon.fnuGetDigitoChequeo');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.fnuGetDigitoChequeo',3);        
    
        -- <Com>Se obtiene el digito de chequeo para un cupón.</Com>
        pkBp_PrintMgr.getCheckDigit ( inuCupoNume, nuDigCheck );
        
        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.fnuGetDigitoChequeo',3);        
        pkErrors.pop;

        -- <Com>Retorna el digito de chequeo correspondiente al cupón ingresado.</Com>
        RETURN nuDigCheck;

    EXCEPTION
        WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fnuGetDigitoChequeo',3);
            pkerrors.pop;
            RAISE;
        WHEN OTHERS THEN
            pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fnuGetDigitoChequeo',3);
            pkerrors.pop;
            RAISE;
    END fnuGetDigitoChequeo;

    FUNCTION fdtFechaPagoFact
    (
        inuFactura  IN  FACTURA.FACTCODI%TYPE
    )
    RETURN CUENCOBR.CUCOFEPA%TYPE   
    IS
    
        -- fecha pago factura
        CURSOR cuFechaPagoFact
        IS
        SELECT MIN(Cucofepa)
          FROM cuencobr
         WHERE cucofact = inuFactura
           AND cucofepa IS NOT NULL;
        
        dtFechaPagoFact   CUENCOBR.CUCOFEPA%TYPE;   
        
    BEGIN
        pkErrors.push('pkg_Epm_WebCoupon.fdtFechaPagoFact');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicio pkg_Epm_WebCoupon.fdtFechaPagoFact', 3);
        
        -- Inicializa variables
        dtFechaPagoFact := NULL;
        
        OPEN  cuFechaPagoFact;
        FETCH cuFechaPagoFact INTO dtFechaPagoFact;
        CLOSE cuFechaPagoFact;

        Pkg_Epm_Utilidades.Trace_SetMsg('Fin pkg_Epm_WebCoupon.fdtFechaPagoFact', 3);
        pkErrors.pop;

        RETURN dtFechaPagoFact;
    
    EXCEPTION
        WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fdtFechaPagoFact',3);
            pkerrors.pop;
            RAISE;
        WHEN OTHERS THEN
            pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fdtFechaPagoFact',3);
            pkerrors.pop;
            RAISE;
    END fdtFechaPagoFact;
    
    ----------------------------------------------
    -- GetLatestInvoices
    ----------------------------------------------
    /*
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>GetLatestInvoices</Unidad>
    <Descripcion>
       API para consultar las facturas y cupones de pago del contrato (6 Ultimos).
    </Descripcion>
    <Autor>lcruzp - Axede</Autor>
    <Fecha>15-01-2015</Fecha>
    <Parametros>
        <param nombre="inuSuscCodi" tipo="SUSCRIPC.SUSCCODI" direccion="IN">Codigo del contrato.</param>
        <param nombre="orcRecordSet" tipo="SYS_REFCURSOR" direccion="OUT">
            Factura                  nuFactCodi       NUMBER(10)
            Contrato                 nuFactSusc       NUMBER(8)
            Cupon                    nuCupoNume       NUMBER(12)
            Fecha Cupon              dtCupoFech       DATE
            Valor Cupon              nuCupoValo       NUMBER(13,2)
            Valor Factura            nuFactVato       NUMBER(13,2)
            Ciclo                    nuFactCicl       NUMBER(4)
            Año Factura              nuFactAno        NUMBER(4)
            Mes Factura              nuFactMes        NUMBER(2)
            Mes (Letras)             sbDescMes        VARCHAR2(20)
            Fecha Factura            dtFactFege       DATE
            Fecha para Pago          dtPefaFepa       DATE
            Fecha Limite Pago        dtPefaFfpa       DATE
            Fecha Recaudo            dtFactFepa       DATE
            Banco                    sbBanco          VARCHAR2(40)
            Oficina                  sbOficina        VARCHAR2(40)
        </param>
        <param nombre="onuCodigoError" tipo="pkg_epm_utilidades.tycodigoerror" direccion="OUT">Codigo del error presentado 0 Exito.</param>
        <param nombre="osbMensajeError" tipo="pkg_epm_utilidades.tymensajeerror" direccion="OUT">Mensaje del error reportado por el aplicativo.</param>
    </Parametros>
    <Historial>        
      <Modificacion Autor="jpinedc" Fecha="24-03-2015" Inc="OC467849">
          Se modifica en el metodo GetLatestInvoices el cursor referenciado incluyento
          el programa EPMPFM          
      </Modificacion>            
        <Modificacion Autor="lfcruz" Fecha="15-01-2015" Inc="OC_446796">
           Creacion del metodo.
        </Modificacion>
    </Historial>
    </Procedure>
    */
    PROCEDURE GetLatestInvoices
    (
        inuSuscCodi      IN   SUSCRIPC.SUSCCODI%TYPE,
        orcRecordSet     OUT  SYS_REFCURSOR,
        onuCodigoError   OUT  pkg_Epm_Utilidades.tyCodigoError,
        osbMensajeError  OUT  pkg_Epm_Utilidades.tyMensajeError
    )
    IS
        -- Variables control
        blExiste              BOOLEAN := FALSE;
        nuLastDaytoDate       NUMBER;

        -- Cursor Salida
        TYPE tyRecordSet      IS REF CURSOR;
        rcRecordSet           tyRecordSet;
        ircRecordSet          tyRecordSet;
        ----------------------------------------------
        -- Initialize
        ----------------------------------------------
        PROCEDURE Initialize
        (
            onuCodigoError   OUT  Pkg_Epm_Utilidades.tycodigoerror,
            osbMensajeError  OUT  Pkg_Epm_Utilidades.tymensajeerror
        )
        IS
        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.Initialize');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetLatestInvoices.Initialize',4);

            -- Inicializa variables de salida Fallo
            pkErrors.Initialize;
            -- pkErrors.SetApplication (sbPrograma);
            onuCodigoError  := pkConstante.EXITO;
            osbMensajeError := pkConstante.NULLSB;
            -- Numero de (n) ultimas facturas a retornar en la consulta
            cnuNUMEULTI_FACTWEB := pkg_EPM_BOParametr.fnuGet('EPM_NUMEULTI_FACTWEB');

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetLatestInvoices.Initialize',4);
            pkErrors.Pop;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.Initialize',4);
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.Initialize',4);
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.Initialize',4);
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END Initialize;
        ----------------------------------------------
        -- ClearMemory
        ----------------------------------------------
        PROCEDURE ClearMemory
        IS
        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.ClearMemory');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetLatestInvoices.ClearMemory',4);

            -- Inicializa Memoria Cache
            pkTblSuscripc.ClearMemory;
            pkTblBanco.ClearMemory;
            pkTblSucuBanc.ClearMemory;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetLatestInvoices.ClearMemory',4);
            pkErrors.Pop;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.ClearMemory',4);
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.ClearMemory',4);
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.ClearMemory',4);
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END ClearMemory;
        ----------------------------------------------
        -- creaInformacion
        ----------------------------------------------
        PROCEDURE creaInformacion
        (
            ircRecordSet IN OUT NOCOPY SYS_REFCURSOR
        )
        IS
            pos              NUMBER;
            nuFactCtrl       NUMBER(10);

            nuFactCodi       NUMBER(10);
            nuFactSusc       NUMBER(8);
            nuCupoNume       NUMBER(12);
            dtCupoFech       DATE;
            nuCupoValo       NUMBER(13,2);
            nuFactVato       NUMBER(13,2);
            nuFactCicl       NUMBER(4);
            nuFactAno        NUMBER(4);
            nuFactMes        NUMBER(2);
            sbDescMes        VARCHAR2(20);
            dtFactFege       DATE;
            dtPefaFepa       DATE;
            dtPefaFfpa       DATE;
            dtFactFepa       DATE;
            sbBanco          VARCHAR2(40);
            sbOficina        VARCHAR2(40);

        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.GetLatestInvoices.creaInformacion');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetLatestInvoices.creaInformacion',4);

            pos := tblDatFacWeb.COUNT;

            FETCH ircRecordSet
             INTO nuFactCodi, nuFactSusc, nuCupoNume, dtCupoFech, nuCupoValo, nuFactVato, nuFactCicl, nuFactAno, nuFactMes, sbDescMes, 
                  dtFactFege, dtPefaFepa, dtPefaFfpa, dtFactFepa, sbBanco, sbOficina;

            nuFactCtrl := -1;

            WHILE ( ircRecordSet%FOUND AND nuFactCodi IS NOT NULL AND pos < (cnuNUMEULTI_FACTWEB + 1) ) LOOP -- Ultimas (n) facturas
            
                IF (nuFactCtrl != nuFactCodi) THEN
                    -- Set de datos
                    tblDatFacWeb(pos).nuFactCodi := nuFactCodi;
                    tblDatFacWeb(pos).nuFactSusc := nuFactSusc;
                    tblDatFacWeb(pos).nuCupoNume := nuCupoNume;
                    tblDatFacWeb(pos).dtCupoFech := dtCupoFech;
                    tblDatFacWeb(pos).nuCupoValo := nuCupoValo;
                    tblDatFacWeb(pos).nuFactVato := nuFactVato;
                    tblDatFacWeb(pos).nuFactCicl := nuFactCicl;
                    tblDatFacWeb(pos).nuFactAno  := nuFactAno;
                    tblDatFacWeb(pos).nuFactMes  := nuFactMes;
                    tblDatFacWeb(pos).sbDescMes  := fsbGetMonthDesc(nuFactMes);
                    tblDatFacWeb(pos).dtFactFege := dtFactFege;
                    tblDatFacWeb(pos).dtPefaFepa := dtPefaFepa;
                    tblDatFacWeb(pos).dtPefaFfpa := dtPefaFfpa;
                    tblDatFacWeb(pos).dtFactFepa := dtFactFepa;
                    tblDatFacWeb(pos).sbBanco    := sbBanco;
                    tblDatFacWeb(pos).sbOficina  := sbOficina;

                    pos := pos + 1;
                    tblDatFacWeb.EXTEND(1, 1);
                    nuFactCtrl := nuFactCodi;
                END IF;

                FETCH ircRecordSet
                 INTO nuFactCodi, nuFactSusc, nuCupoNume, dtCupoFech, nuCupoValo, nuFactVato, nuFactCicl, nuFactAno, nuFactMes, sbDescMes,
                      dtFactFege, dtPefaFepa, dtPefaFfpa, dtFactFepa, sbBanco, sbOficina;

            END LOOP;

            pos := tblDatFacWeb.COUNT;
            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetLatestInvoices.creaInformacion',4);
            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.creaInformacion',4);
                Pkerrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN Pkconstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.creaInformacion',4);
                Pkerrors.Pop;
                RAISE Pkconstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                Pkerrors.NotifyError( Pkerrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.creaInformacion',4);
                Pkerrors.Pop;
                RAISE_APPLICATION_ERROR( Pkconstante.nuERROR_LEVEL2, sbErrMsg );
        END creaInformacion;
        ----------------------------------------------
        -- Consultar
        ----------------------------------------------
        PROCEDURE Consultar
        (
            inuSuscCodi  IN  SUSCRIPC.SUSCCODI%TYPE,
            orcRecordSet OUT NOCOPY SYS_REFCURSOR
        )
        IS

        BEGIN

            pkErrors.Push('pkg_Epm_WebCoupon.GetLatestInvoices.Consultar');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetLatestInvoices.Consultar',4);

            -- <Com>Seleccion que Recupera los Cupones para pago.</Com>
            IF (orcRecordSet%ISOPEN) THEN
                CLOSE orcRecordSet;
            END IF;

            nuLastDaytoDate := (((cnuNUMEULTI_FACTWEB + 1) * 30) + (cnuNUMEULTI_FACTWEB + 1)) * 2; -- El doble de los ultimos (n) dias
            -- <Com>Volca todos los Datos de la Seleccion de Consulta.</Com>
            OPEN orcRecordSet FOR
            SELECT factcodi, factsusc, TO_NUMBER(cuponume||LPAD(fnuGetDigitoChequeo(cuponume), 2, 0)) cuponume, cupofech, cupovalo, 
                   fnuObtValFactura(factura.factcodi) factvato, pefacicl factcicl,
                   pefaano factano, pefames factmes, 'MES' descmes, factfege, pefafepa, pefaffpa, fdtFechaPagoFact(factcodi) factfepa,
                   DECODE( fdtFechaPagoFact(factcodi), NULL, NULL, DECODE(pagobanc, NULL, NULL, pktblbanco.fsbgetbancnomb(pagobanc))) banco,
                   DECODE( fdtFechaPagoFact(factcodi), NULL, NULL, DECODE(pagosuba, NULL, NULL, pktblsucubanc.fsbgetsubanomb(pagobanc, pagosuba))) oficina
              FROM factura, cupon, perifact,
                   (SELECT pagofepa, pagosuba, pagobanc, cupodocu ducumento
                      FROM pagos, cupon 
                     WHERE pagosusc = inuSuscCodi
                       AND pagocupo = cuponume
                     ORDER BY pagocupo DESC) DATA_PAGO
             WHERE factsusc = inuSuscCodi
               AND TRUNC(factfege) > TRUNC(SYSDATE) - nuLastDaytoDate
               AND factnufi > 0
               AND facttico = 1
               AND cupodocu = TO_CHAR(factcodi)
               AND cupoprog IN ( 'FIFA', 'EPMPFM' )
               AND cupocupa IS NULL -- www
               AND pefacodi = factpefa
               AND TO_CHAR(factcodi) = DATA_PAGO.ducumento(+)
               AND NVL(DATA_PAGO.pagofepa(+), fdtFechaPagoFact(factcodi)) = fdtFechaPagoFact(factcodi)
             ORDER BY factcodi DESC, cuponume DESC;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetLatestInvoices.Consultar',4);
            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.Consultar',4);
                Pkerrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN Pkconstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.Consultar',4);
                Pkerrors.Pop;
                RAISE Pkconstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                Pkerrors.NotifyError( Pkerrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices.Consultar',4);
                Pkerrors.Pop;
                RAISE_APPLICATION_ERROR( Pkconstante.nuERROR_LEVEL2, sbErrMsg );
        END Consultar;

    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.GetLatestInvoices');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetLatestInvoices',3);

        -- <Com>Limpia Fallo.</Com>
        Initialize (onuCodigoError, osbMensajeError);
        -- <Com>Limpia Memoria Cache.</Com>
        ClearMemory;

        -- Valida Datos de Consulta.
        -- <Com>Valida con contrato de entrada.</Com>
        blExiste := pkTblSuscripc.fblExist(inuSuscCodi, cnuNOCACHE);
        IF (NOT blExiste) THEN
            -- <Men cod="EPM-BIL-10050">Suscripcion no Existe</Men>
            pkErrors.setErrorCode (csbDivisionEPM, csbModuloBIL, cnuINVALID_NOSUSCR);
            RAISE LOGIN_DENIED;
        END IF;

        -- <Com>Consulta Datos</Com>
        -- se inicializa la tabla con una posicion nula.
        tblDatFacWeb := tblDatFacWeb_EMPTY;
        Consultar(inuSuscCodi, ircRecordSet);
        creaInformacion(ircRecordSet);

        IF (ircRecordSet%ISOPEN) THEN
           CLOSE ircRecordSet;
        END IF;
                
        -- Elimina el ultimo reg sin datos
        tblDatFacWeb.DELETE(tblDatFacWeb.COUNT);

        -- <Com>Obtiene Cursor con Datos de Salida</Com>
        IF ( tblDatFacWeb.COUNT > 0 AND tblDatFacWeb(tblDatFacWeb.COUNT).nuFactCodi IS NOT NULL ) THEN

            OPEN rcRecordSet FOR
            SELECT nuFactCodi,
                   nuFactSusc,
                   nuCupoNume,
                   dtCupoFech,
                   nuCupoValo,
                   nuFactVato,
                   nuFactCicl,
                   nuFactAno,
                   nuFactMes,
                   sbDescMes,
                   dtFactFege,
                   dtPefaFepa,
                   dtPefaFfpa,
                   dtFactFepa,
                   sbBanco,
                   sbOficina
              FROM TABLE(CAST(tblDatFacWeb AS epm_tyDatFacWeb))
             ORDER BY nuFactCodi;

        ELSE
            -- <Men cod="EPM-BIL-12489">No se encontraron facturas en los ultimos [%s1] dias para el contrato ingresado.</Men>
            pkErrors.setErrorCode (csbDivisionEPM, csbModuloBIL, cnuINVALID_NOFACTURA);
            pkErrors.changeMessage ('%s1', TRUNC(nuLastDaytoDate/30));
            RAISE LOGIN_DENIED;
        END IF;

        -- <Com>Asigna Registro de Datos de Salida</Com>
        orcRecordSet := rcRecordSet;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetLatestInvoices',3);
        pkErrors.pop;

    EXCEPTION
        WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices',3);
            pkErrors.Pop;
            pkErrors.GetErrorVar(onuCodigoError, osbMensajeError);
            openCursorFactNull(orcRecordSet);
        WHEN OTHERS THEN
            pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetLatestInvoices',3);
            pkErrors.Pop;
            openCursorFactNull(orcRecordSet);
            RAISE_APPLICATION_ERROR (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END GetLatestInvoices;

    ----------------------------------------------
    -- fsbVersion
    ----------------------------------------------
    /*
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellín">
    <Unidad>fsbVersion</Unidad>
    <Descripcion>
    Función que retorna la ultima OC que modifico el paquete.
    </Descripcion>
    <Autor>lfcruz - Trebol Software S.A</Autor>
    <Fecha>20-Ago-2009</Fecha>
    <Retorno Nombre="csbVersion" Tipo="VARCHAR2">
    Identificador de la OC o requerimiento que modifica el paquete.
    </Retorno>
    <Historial>
        <Modificacion Autor="lcruzp" Fecha="20-Ago-2009" Inc="OC61239">
        Creación del Método.
        </Modificacion>
    </Historial>
    </Procedure>
    */
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /*
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>GetCupones</Unidad>
    <Descripcion>
    API para consultar los cupones de pago de suscripcion.
    </Descripcion>
    <Autor>Carlos Andrés Dominguez N ( cdominn ) Axede S.A</Autor>
    <Fecha>02-Nov-2011</Fecha>
    <Parametros>
        <param nombre="ircRecordSet" tipo="SYS_REFCURSOR" direccion="IN">Cursor referenciado de contratos</param>
        <param nombre="orcRecordSet" tipo="SYS_REFCURSOR" direccion="OUT">Cursor referenciado de cupones</param>
        <param nombre="onuCodigoError" tipo="pkg_epm_utilidades.tycodigoerror" direccion="OUT">Codigo del Error Presentado 0 Exito.</param>
        <param nombre="osbMensajeError" tipo="pkg_epm_utilidades.tymensajeerror" direccion="OUT">Mensaje del error reportado por el aplicatvo.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="VJIMENEC" Fecha="14-Dic-2018" Inc="OC835020">
         * Se realizar Ajuste en GetCupones con el fin de que se permita visualizar los cupones para pago de las facturas pendientes de pago del último periodo vigente de facturación,
            antes del ajuste solo se visualizan los cupones de la última factura del último periodo de facturación.
        </Modificacion>
        <Modificacion Autor="VJIMENEC" Fecha="04-12-2018" Inc="OC830725">
            * Se crea nueva funcion fnuObtValFactura que Obtiene el Valor Total de la Factura - Valor de Notas Generadas por Concepto de Anulación de Pagos.
            Se Modifica procedimiento Consultar, en la consulta que obtiene el historial de las facturas para obtener el valor total de la misma, invocando la nueva funcion.
        </Modificacion>
        <Modificacion Autor="jpinedc" Fecha="31-Jul-2014" Inc="OC402523">
        * Se modifica GetCupones para que no procese contratos que lleguen nulos
        en la cadena de entrada isbContratos
        </Modificacion>
        <Modificacion Autor="jpinedc" Fecha="29-Jul-2014" Inc="OC">
         Se modifica para que evalúe si hubo error al ejecutar GetDataCupon.
         Si no hubo error inserta en EPM_WEBCUPON
         para los registros que tienen algun error en validación.         
        </Modificacion>        
        <Modificacion Autor="jpinedc" Fecha="26-Jul-2012" Inc="OC223155">
         Se modifica el metodo GetCupones para que incremente el contador de registros
         nuTotalDatos
         para los registros que tienen algun error en validación.
        </Modificacion>        
        <Modificacion Autor="cdominn" Fecha="02-Nov-2011" Inc="OC183440">
        Creación del Método.
        </Modificacion>
    </Historial>
    </Procedure>
    */
    
    PROCEDURE GetCupones
    (
        ircRecordSet     IN   SYS_REFCURSOR,
        orcRecordSet     OUT  SYS_REFCURSOR,
        onuCodigoError   OUT  Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError  OUT  Pkg_Epm_Utilidades.tymensajeerror
    )
    IS
        rcDatos         tyrcDatos;
        nuContrato      SUSCRIPC.SUSCCODI%TYPE;
        nuIndex         NUMBER;
        rcRecordSet     SYS_REFCURSOR;
        nuTotalDatos    NUMBER := 0;
        nuCtaVencSusc   NUMBER := 0;
        rcFactura       FACTURA%ROWTYPE;
        
        PROCEDURE openCursorNull
        (
            orcRecordSet   OUT   SYS_REFCURSOR
        )
        IS
        BEGIN
            -- <Com>Cierra Cursor Referencia.</Com>
            IF (orcRecordSet%ISOPEN) THEN
                CLOSE orcRecordSet;
            END IF;

            -- Consulta Nulo
            OPEN orcRecordSet FOR
            SELECT TO_NUMBER(NULL) wecunucu,
                   TO_NUMBER(NULL) wecususc,
                   TO_NUMBER(NULL) wecufact,
                   TO_NUMBER(NULL) wecuvacu,
                   TO_DATE(NULL)   wecufepa,
                   TO_DATE(NULL)   wecuffpa,
                   TO_NUMBER(NULL) wecucoer,
                   TO_CHAR(NULL)   wecumeer,
                   TO_NUMBER(NULL) saldo,
                   TO_NUMBER(NULL) wecucuve,
                   TO_DATE(NULL)   wecufefa,
                   TO_CHAR(NULL)   wecuticu
              FROM DUAL;

        EXCEPTION
            WHEN LOGIN_DENIED THEN
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END openCursorNull;

        /* ******************************************************************************************************* */
        PROCEDURE Initialize
        (
            onuCodigoError   OUT  Pkg_Epm_Utilidades.TYCODIGOERROR,
            osbMensajeError  OUT  Pkg_Epm_Utilidades.TYMENSAJEERROR
        )
        IS
        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.Initialize');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetCupones.Initialize',4);

            -- Inicializa variables de Salida Fallo
            pkErrors.Initialize;
            onuCodigoError  := pkConstante.EXITO;
            osbMensajeError := pkConstante.NULLSB;
            nuIndex := 1;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetCupones.Initialize',4);
            pkErrors.Pop;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones.Initialize',4);
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones.Initialize',4);
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones.Initialize',4);
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END Initialize;
        /* ******************************************************************************************************* */                
    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.GetCupones');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetCupones',4);
        
        Initialize (onuCodigoError, osbMensajeError) ;
        
        FETCH ircRecordSet INTO nuContrato;
        
        IF ( ircRecordSet%NOTFOUND ) THEN
            pkErrors.setErrorCode (csbDivisionEPM, csbModuloBIL, cnuINVALID_NOSUSCR);
            onuCodigoError  := 10050;
            osbMensajeError := 'Suscripcion no Existe';
            RAISE LOGIN_DENIED;        
        END IF;
        
        LOOP
            EXIT WHEN ircRecordSet%NOTFOUND;

            onuCodigoError  := 0;
            osbMensajeError := NULL;

            IF (nuContrato IS NOT NULL) THEN

                GetDataCupon
                (
                  -1,
                  nuContrato,
                  rcRecordSet,
                  onuCodigoError,
                  osbMensajeError
                );

                -- Reccorre el cursor que se retorna por contrato
                FETCH rcRecordSet INTO rcDatos;
                IF ( rcDatos.NumeroCupon IS NOT NULL ) THEN
                    LOOP
                        EXIT WHEN rcRecordSet%NOTFOUND;
                        nuIndex := nuIndex + 1;

                        rcFactura := NULL;
                        
                        -- Obtiene máximo número de cuentas vencidas del contrato
                        nuCtaVencSusc := fnuGetCtaVencSusc(rcDatos.Contrato);

                        -- Obtiene fecha de generación de la factura
                        rcFactura := pktblfactura.frcgetrecord(rcDatos.CodigoFactura);

                        -- Inserta registros en epm_webcupon
                        INSERT INTO epm_webcupon VALUES 
                        (
                            rcDatos.NumeroCupon, rcDatos.Contrato,
                            rcDatos.CodigoFactura,rcDatos.ValorCupon,
                            rcDatos.FechaPago,rcDatos.FinalPago,
                            onuCodigoError,osbMensajeError, rcDatos.saldo,
                            nuCtaVencSusc, rcFactura.factfege,
                            rcDatos.TipoCupon
                        );
                        nuTotalDatos := nuTotalDatos + 1;
                        
                        FETCH rcRecordSet INTO rcDatos;
                    END LOOP;

                ELSE
                    INSERT INTO epm_webcupon VALUES (NULL, nuContrato, NULL, NULL, NULL, NULL, onuCodigoError, osbMensajeError, NULL, NULL, NULL, NULL);
                    nuTotalDatos := nuTotalDatos + 1;
                END IF;
                    
                CLOSE rcRecordSet;
                
            ELSE
                Pkg_Epm_Utilidades.Trace_SetMsg('El contrato es nulo entonces no se procesa',5);
            END IF;                

            FETCH ircRecordSet INTO nuContrato; -- siguiente contrato a procesar
            
        END LOOP;
        
        CLOSE ircRecordSet;

        IF (orcRecordSet%ISOPEN) THEN
            CLOSE orcRecordSet;
        END IF;

        IF (nuTotalDatos > 0) THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('nuTotalDatos > 0 : Retorna Cursor sobre EPM_WEBCUPON',3);

            -- Abre cursor referenciado
            OPEN orcRecordSet FOR
            SELECT wecunucu, wecususc, wecufact, wecuvacu, wecufepa, wecuffpa, wecucoer, wecumeer, wecusald saldo,
                   wecucuve, wecufefa, wecuticu
              FROM epm_webcupon
             WHERE wecusald > 0
             ORDER BY wecucuve DESC;

        ELSE
            Pkg_Epm_Utilidades.Trace_SetMsg('nuTotalDatos <= 0 : Retorna cursor nulo', 3);
            openCursorNull(orcRecordSet);
        END IF;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetCupones', 3);
        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones',3);
            pkerrors.pop;
            openCursorNull (orcRecordSet);
            pkerrors.geterrorvar (onuCodigoError, osbMensajeError);
        WHEN OTHERS THEN
            pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones',3);
            pkerrors.pop;
            openCursorNull (orcRecordSet);
            RAISE_APPLICATION_ERROR (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END GetCupones;

    --Procedimeinto encargado de convertir una cadena separada por comas, en un cursor referenciado
    --este método fue creado por un alcance técnico que no pude manejar .Net, ya que desde 
    --.Net se creaba un cursor referenciado y cuando se enviaba a un método almacenado en la DB
    --oracle no es capaz de iterarlo.
    PROCEDURE getCurContratos
    (
         isbContratos IN  VARCHAR2,
         ircRecordSet OUT SYS_REFCURSOR
    )
    IS
    BEGIN
        pkErrors.Push('pkg_Epm_WebCoupon.getCurContratos');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.getCurContratos',3);

        OPEN ircRecordSet FOR SELECT TO_NUMBER(COLUMN_VALUE) contrato FROM TABLE(Pkg_Epm_Utilidades.Split(isbContratos));
        
        Pkg_Epm_Utilidades.Trace_SetMsg('Termina pkg_Epm_WebCoupon.getCurContratos',3);
        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED OR Pkconstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Error aplicacion pkg_Epm_WebCoupon.getCurContratos',5);
            Pkerrors.Pop;
            RAISE LOGIN_DENIED;
        WHEN OTHERS THEN
            Pkerrors.NotifyError( Pkerrors.fsbLastObject, SQLERRM, sbErrMsg );
            Pkg_Epm_Utilidades.Trace_SetMsg('Error others pkg_Epm_WebCoupon.getCurContratos',5);
            Pkerrors.Pop;
            RAISE_APPLICATION_ERROR( Pkconstante.nuERROR_LEVEL2, sbErrMsg );
    END getCurContratos;

    /*
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>GetCupones</Unidad>
    <Descripcion>
    API para consultar los cupones de pago de suscripcion.
    </Descripcion>
    <Autor>Jairo Alejandro Londoño R. - Axede S.A</Autor>
    <Fecha>31-May-2012</Fecha>
    <Parametros>
        <param nombre="isbContratos" tipo="VARCHAR2" direccion="IN">Cadena de contratos separados por coma.</param>
        <param nombre="orcRecordSet" tipo="SYS_REFCURSOR" direccion="OUT">Cursor referenciado de cupones</param>
        <param nombre="onuCodigoError" tipo="pkg_epm_utilidades.tycodigoerror" direccion="OUT">Codigo del Error Presentado 0 Exito.</param>
        <param nombre="osbMensajeError" tipo="pkg_epm_utilidades.tymensajeerror" direccion="OUT">Mensaje del error reportado por el aplicatvo.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="jlondonr" Fecha="31-May-2012" Inc="OC223155">
         Creación del Método.
        </Modificacion>
    </Historial>
    </Procedure>
    */
    PROCEDURE GetCupones
    (
        isbContratos    IN  VARCHAR2,
        orcRecordSet    OUT SYS_REFCURSOR,
        onuCodigoError  OUT Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError OUT Pkg_Epm_Utilidades.tymensajeerror
    )
    IS
        rcContratos SYS_REFCURSOR;

        PROCEDURE Initialize
        (
            onuCodigoError   OUT  Pkg_Epm_Utilidades.TYCODIGOERROR,
            osbMensajeError  OUT  Pkg_Epm_Utilidades.TYMENSAJEERROR
        )
        IS
        BEGIN
            pkErrors.Push('pkg_Epm_WebCoupon.GetCupones.Initialize');
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetCupones.Initialize',4);
            -- Inicializa variables de Salida Fallo

            pkErrors.Initialize;
            -- pkErrors.SetApplication (sbPrograma); --N/A
            onuCodigoError  := pkConstante.EXITO;
            osbMensajeError := pkConstante.NULLSB;
            --Borrado datos tabla para que no almacene datos cada vez que desde .Net se invoca.
            DELETE epm_webcupon;

            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.GetCupones.Initialize',4);
            pkErrors.Pop;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones.Initialize',4);
                pkErrors.Pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones.Initialize',4);
                pkErrors.Pop;
                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.GetCupones.Initialize',4);
                pkErrors.Pop;
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END Initialize;

    BEGIN

        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.GetCupones',3);
        
        --inicializar variables codigo y mensaje de error.
        Initialize(onuCodigoError, osbMensajeError);

        Pkg_Epm_Utilidades.Trace_SetMsg('isbContratos:'||isbContratos,3);
        --procedimiento para trasformar una cadena de contratos en un cursor referenciado
        getCurContratos(isbContratos,rcContratos);
        Pkg_Epm_Utilidades.Trace_SetMsg('Se llamo a getCurContratos',3);
        
        GetCupones(rcContratos, orcRecordSet, onuCodigoError, osbMensajeError);

        IF (rcContratos%ISOPEN) THEN
           Pkg_Epm_Utilidades.Trace_SetMsg('Cierra cursor rcContratos armado de cadena',3);
           CLOSE rcContratos;
        END IF;

        Pkg_Epm_Utilidades.Trace_SetMsg('Termina pkg_Epm_WebCoupon.GetCupones',3);
    EXCEPTION
        WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores apl pkg_Epm_WebCoupon.GetCupones',3);
            pkerrors.pop;
            IF rcContratos%ISOPEN THEN
               CLOSE rcContratos;
            END IF;
            pkerrors.geterrorvar (onuCodigoError, osbMensajeError);
        WHEN OTHERS THEN
            pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin others con errores pkg_Epm_WebCoupon.GetCupones',3);
            pkerrors.pop;
            IF rcContratos%ISOPEN THEN
               CLOSE rcContratos;
            END IF;
            RAISE_APPLICATION_ERROR (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END GetCupones;
    
    
    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> pGetInvoiceDetail </Unidad>
    <Descripcion>
        Permite consultar la información detallada de los grupos de servicio de una factura.
    </Descripcion>
    <Autor> Jhonatan Hernandez Silva - AXEDE S.A </Autor>
    <Fecha> 24/09/2015 </Fecha>
    <Parametros>
    <param nombre="INUFACTCODI" tipo="NUMBER(10,0)" Direccion="IN" >Número de Factura</param>
    <param nombre="ORCRECORDSET" tipo="REF CURSOR" Direccion="OUT" >Cursor referenciado con valores de los grupos de servicio</param>
    <param nombre="ONUERRORCODE" tipo="NUMBER(15,0)" Direccion="OUT" >Código de error</param>
    <param nombre="OSBERRORMSG" tipo="VARCHAR2" Direccion="OUT" >Mensaje de error</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="jhernasi" Fecha="24-09-2015" Inc="OC522953">
        Creacion
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    PROCEDURE pGetInvoiceDetail
    (
        inuFactcodi      IN   FACTURA.FACTCODI%TYPE,
        orcRecordSet     OUT  SYS_REFCURSOR,
        onuErrorCode     OUT  pkg_Epm_Utilidades.tyCodigoError,
        osbErrorMsg      OUT  pkg_Epm_Utilidades.tyMensajeError
    )
    IS
        ----------------------------------------------
        -- Tipos de datos
        ---------------------------------------------- 
        TYPE tyrcConsumos IS RECORD
        (
            nuAno            PERIFACT.PEFAANO%type,
            nuMes            PERIFACT.PEFAMES%type,
            nuConsumo        CONSSESU.COSSCOCA%type,
            sbUnidMedi       UNIDMEDI.UNMEDESC%type
        );
        
        
        TYPE tytbConsumos IS TABLE OF tyrcConsumos INDEX BY BINARY_INTEGER; 
        
        TYPE tyrcDetFactWeb IS RECORD
        (
            sbGrupoServ      EPM_GRUPSEFW.GRSFDESC%TYPE,
            sbServicio       SERVICIO.SERVDESC%TYPE,
            nuValorCuenta    CUENCOBR.CUCOVATO%TYPE,
            tbConsumos       tytbConsumos
        );
        
        TYPE tytbDetFactWeb IS TABLE OF tyrcDetFactWeb INDEX BY BINARY_INTEGER; 

        TYPE tyrcGrupoServ IS RECORD
        (
            nuGrupoServ    NUMBER(5,0),
            sbDescGrupo    EPM_GRUPSEFW.GRSFDESC%TYPE,
            sbDescServ     SERVICIO.SERVDESC%TYPE
        );
        
        TYPE tytbGrupoServ IS TABLE OF tyrcGrupoServ INDEX BY BINARY_INTEGER;
        
        ----------------------------------------------
        -- Variables
        ----------------------------------------------
        tbDetFactWeb    tytbDetFactWeb; 
        tbGrupoServ     tytbGrupoServ;
        
        ----------------------------------------------
        -- Procedimientos
        ----------------------------------------------
        PROCEDURE Initialize
        IS
        BEGIN
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.pGetInvoiceDetail.Initialize',4);

            -- Inicializa variables de salida Fallo
            pkErrors.Initialize;
            onuErrorCode  := pkConstante.EXITO;
            osbErrorMsg   := pkConstante.NULLSB;
            
            -- Inicializa variables de proceso
            tbDetFactWeb.DELETE;
            tbGrupoServ.DELETE;
            
             -- se inicializa la tabla con una posicion nula.
            tblCurDetFacWeb := tblCurDetFacWeb_EMPTY;

            -- Cierra el cursor referenciado si se encuentra abierto.
            IF ( orcRecordSet%ISOPEN ) THEN
                CLOSE orcRecordSet;
            END IF;
            
            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pGetInvoiceDetail.Initialize',4);
            
        EXCEPTION
            WHEN LOGIN_DENIED or pkConstante.exERROR_LEVEL2  THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.Initialize',4);
                RAISE;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.Initialize',4);
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END Initialize;
        
        PROCEDURE ObtenerConsumos
        (
            inuProducto   IN  SERVSUSC.SESUNUSE%TYPE,
            inuContrato   IN  SERVSUSC.SESUSUSC%TYPE,
            inuPeriodo    IN  PERIFACT.PEFACODI%TYPE,
            otbConsumos   OUT NOCOPY tytbConsumos
        )
        IS
            -- consumo facturado en el periodo
            CURSOR cuConsFactPer
            (
                inuProducto  IN  CONSSESU.COSSSESU%TYPE,
                inuPeriFact  IN  CONSSESU.COSSPEFA%TYPE
            )
            IS
            select sum(cosscoca)
            from   conssesu
            where  cosssesu = inuProducto
            and    cosspefa = inuPeriFact
            and    cossflli = 'S'
            and    cossmecc = cnuMET_CAL_CONSFACT
            and    instr(','||csbEPM_TIPOCONS_FACTWEB||',',','||cosstcon||',') > 0;
            
            -- Unidad Medida consumo facturado en el periodo
            CURSOR cuUniMedConsFactPer
            (
                inuProducto  IN  CONSSESU.COSSSESU%TYPE,
                inuPeriFact  IN  CONSSESU.COSSPEFA%TYPE
            )
            IS
            select unmedesc
            from   conssesu,tipocons, unidmedi
            where  cosstcon = tconcodi
            and    tconunme = unmecons
            and    cosssesu = inuProducto
            and    cosspefa = inuPeriFact
            and    cossflli = 'S'
            and    cossmecc = cnuMET_CAL_CONSFACT
            and    instr(','||csbEPM_TIPOCONS_FACTWEB||',',','||cosstcon||',') > 0
            order by cosstcon;
            
            CURSOR cuPeriodoAnterior 
            (
                 inuContrato   IN servsusc.sesususc%TYPE,
                 inuProducto   IN servsusc.sesunuse%TYPE,
                 inuAnoAnt     IN perifact.pefaano%TYPE,
                 inuMesAnt     IN perifact.pefames%TYPE
            )
            IS
            SELECT factpefa
            FROM   cuencobr,factura,perifact
            WHERE  factpefa = pefacodi
            AND    factcodi = cucofact
            AND    factsusc+0 = inuContrato
            AND    cuconuse = inuProducto
            AND    pefaano+0  = inuAnoAnt
            AND    pefames+0  = inuMesAnt;
            
            rcPeriodoAnt     perifact%ROWTYPE;
            rcPeriodoAct     perifact%ROWTYPE;
            nuAnoPeriAnt     perifact.pefaano%TYPE;
            nuMesPeriAnt     perifact.pefames%TYPE;
            nuPeriodoAct     perifact.pefacodi%TYPE;
            nuConsFact       conssesu.cosscoca%TYPE;
            sbUniMedConsFact unidmedi.unmedesc%TYPE;
            
        BEGIN
        
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicio pkg_Epm_WebCoupon.pGetInvoiceDetail.ObtenerConsumos',4);
            
            -- Inicializa variables
            rcPeriodoAnt := null;
            rcPeriodoAct := null;
            nuPeriodoAct := null;
            otbConsumos.DELETE;
            
            -- Establece el periodo actual a procesar
            nuPeriodoAct := inuPeriodo;
                        
            for nuIdxPer in  1 .. 3 loop
                
                if( nuPeriodoAct is not null) then
                
                    -- Inicializa variables
                    nuConsFact       := null;
                    sbUniMedConsFact := null;
                    rcPeriodoAct     := null;
                    
                    -- Obtiene el consumo facturado
                    open  cuConsFactPer(inuProducto,nuPeriodoAct);
                    fetch cuConsFactPer into nuConsFact;
                    close cuConsFactPer;

                    -- Obtiene unidad de medida de consumo facturado
                    open  cuUniMedConsFactPer(inuProducto,nuPeriodoAct);
                    fetch cuUniMedConsFactPer into sbUniMedConsFact;
                    close cuUniMedConsFactPer;  
                    
                    -- Obtiene el registro del periodo de fact
                    rcPeriodoAct := pktblperifact.Frcgetrecord(nuPeriodoAct);
                    
                    -- almacena el consumo del producto en el periodo
                    otbConsumos(nuIdxPer).nuConsumo := nuConsFact;
                    otbConsumos(nuIdxPer).nuAno     := rcPeriodoAct.pefaano;
                    otbConsumos(nuIdxPer).nuMes     := rcPeriodoAct.pefames;
                    otbConsumos(nuIdxPer).sbUnidMedi:= sbUniMedConsFact;

                    -- Obtiene el periodo anterior
                    pkBillingPeriodMgr.getPreviousBillPeriod(nuPeriodoAct,rcPeriodoAnt);
                    
                    -- Obtiene año y mes del periodo de facturación anterior
                    nuAnoPeriAnt := rcPeriodoAnt.pefaano;
                    nuMesPeriAnt := rcPeriodoAnt.pefames;
                    nuPeriodoAct := null;
                    
                    -- Obtiene el verdadero periodo de facturacion anterior
                    OPEN  cuPeriodoAnterior(inuContrato,inuProducto,nuAnoPeriAnt,nuMesPeriAnt);
                    FETCH cuPeriodoAnterior INTO nuPeriodoAct;
                    CLOSE cuPeriodoAnterior;

                    -- Si para el producto procesado no se ha generado cuenta de cobro
                    -- en periodo anterior, se toma la información de la tabla perifact
                    IF (nuPeriodoAct IS NULL)  THEN
                        nuPeriodoAct := rcPeriodoAnt.pefacodi;
                    END IF;
                    
                end if;
            
            end loop; 
            
            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pGetInvoiceDetail.ObtenerConsumos',4);
        
        EXCEPTION
            WHEN LOGIN_DENIED or pkConstante.exERROR_LEVEL2  THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.ObtenerConsumos',4);
                RAISE;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.ObtenerConsumos',4);
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END ObtenerConsumos;
        
        PROCEDURE ProcesarFactura
        (
            inuFactura  in factura.factcodi%type
        )
        IS
        
            -- cuentas de la factura
            CURSOR cuCuentasFact
            (
                inuFactura    in  factura.factcodi%type
            )
            IS
            select cucocodi,cuconuse,factpefa,cucovato,sesuserv,sesususc
            from   cuencobr,servsusc,factura
            where  cucofact = inuFactura
            and    cucofact = factcodi
            and    cuconuse = sesunuse; 
            
            -- grupo se servicio
            CURSOR cuGrupoServ
            (
                inuServicio in servsusc.sesuserv%type
            )
            IS
            select segfgrse
            from   epm_servgrfw
            where  segfserv = inuServicio;
            
            TYPE tytbCuentas  IS TABLE OF cuCuentasFact%ROWTYPE INDEX BY BINARY_INTEGER;
            tbCuentas           tytbCuentas;
            nuIdxC              binary_integer;
            nuGrupServ          NUMBER(5,0);
            nuGrupOtros         NUMBER(5,0);
            sbGrupServ          epm_grupsefw.grsfdesc%type;
            nuConsFact          conssesu.cosscoca%type;
            sbDescServ          servicio.servdesc%type;
            tbConsProd          tytbConsumos;
            nuIdxCons           binary_integer;
        
        BEGIN
            
            Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.pGetInvoiceDetail.ProcesarFactura',4);
            
            -- Inicializa variables de proceso
            tbCuentas.delete;
            nuConsFact  := 0;
            nuGrupOtros := 10000;

            open  cuCuentasFact(inuFactura);
            fetch cuCuentasFact bulk collect into tbCuentas;
            close cuCuentasFact;
            
            nuIdxC  := tbCuentas.first;
             
            loop

                exit when nuIdxC is null;
                
                -- Inicializa variables
                nuGrupServ := null;
                sbGrupServ := null;
                sbDescServ := null;
                tbConsProd.delete;

                -- valida si no se ha consultado grupo de servicio 
                if( NOT tbGrupoServ.exists(tbCuentas(nuIdxC).sesuserv)) then
                
                    -- Obtiene el grupo al que pertenece el producto
                    open  cuGrupoServ(tbCuentas(nuIdxC).sesuserv);
                    fetch cuGrupoServ into nuGrupServ;
                    close cuGrupoServ;

                    -- si no existe grupo de servicio
                    if( nuGrupServ is null ) then
                    
                        -- asigna el otros grupos
                        nuGrupServ  := nuGrupOtros;
                        sbGrupServ  := 'OTROS';
                        nuGrupOtros := nuGrupOtros + 1;
                        sbDescServ  := pktblservicio.fsbgetdescription(tbCuentas(nuIdxC).sesuserv);
                        
                    else
                        -- Obtiene la descripcion del grupo de servicios
                        sbGrupServ := pktblepm_grupsefw.frcGetRecord(nuGrupServ).grsfdesc;
                        
                    end if;

                    -- almacena la configuracion del grupo de servicio
                    tbGrupoServ(tbCuentas(nuIdxC).sesuserv).nuGrupoServ := nuGrupServ;
                    tbGrupoServ(tbCuentas(nuIdxC).sesuserv).sbDescGrupo := sbGrupServ;
                    tbGrupoServ(tbCuentas(nuIdxC).sesuserv).sbDescServ  := sbDescServ;
                    
                end if;

                -- Establece el grupo de servicio
                nuGrupServ :=  tbGrupoServ(tbCuentas(nuIdxC).sesuserv).nuGrupoServ;    
                
                IF( tbDetFactWeb.exists(nuGrupServ) ) THEN

                    -- acumula el valor de la cuenta de cobro 
                    tbDetFactWeb(nuGrupServ).nuValorCuenta := tbDetFactWeb(nuGrupServ).nuValorCuenta + tbCuentas(nuIdxC).cucovato;
                                               
                ELSE
                        
                    --  establece el valor de la cuenta de cobro
                    tbDetFactWeb(nuGrupServ).nuValorCuenta := tbCuentas(nuIdxC).cucovato;

                    -- almacena el grupo de servicio
                    tbDetFactWeb(nuGrupServ).sbGrupoServ := tbGrupoServ(tbCuentas(nuIdxC).sesuserv).sbDescGrupo;
                        
                    -- establece las descripcion del servicio
                    tbDetFactWeb(nuGrupServ).sbServicio := tbGrupoServ(tbCuentas(nuIdxC).sesuserv).sbDescServ;
                        
                END IF;
                
                -- Obtiene los consumos del producto
                ObtenerConsumos
                (
                    tbCuentas(nuIdxC).cuconuse,
                    tbCuentas(nuIdxC).sesususc,
                    tbCuentas(nuIdxC).factpefa,
                    tbConsProd
                );
                
                -- recorre los consumos del producto para acumularlos en el grupo
                nuIdxCons := tbConsProd.first;
                
                loop
                    
                    exit when nuIdxCons is null;
                    
                    -- almacena el consumo
                    if( tbDetFactWeb(nuGrupServ).tbConsumos.exists(nuIdxCons)) then

                        tbDetFactWeb(nuGrupServ).tbConsumos(nuIdxCons).nuConsumo := tbDetFactWeb(nuGrupServ).tbConsumos(nuIdxCons).nuConsumo + tbConsProd(nuIdxCons).nuConsumo;
                        
                    else
                            
                        tbDetFactWeb(nuGrupServ).tbConsumos(nuIdxCons) := tbConsProd(nuIdxCons);
                            
                    end if;

                    nuIdxCons := tbConsProd.next(nuIdxCons);
                    
                end loop;
                    
                nuIdxC := tbCuentas.next(nuIdxC);

            end loop;     

                
            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pGetInvoiceDetail.ProcesarFactura',4);
            
        EXCEPTION
            WHEN LOGIN_DENIED or pkConstante.exERROR_LEVEL2  THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.ProcesarFactura',4);
                RAISE;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.ProcesarFactura',4);
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END ProcesarFactura;
        
        PROCEDURE EstablecerInfoSalida
        IS

            nuIdxDet binary_integer;
            nuPos    NUMBER;
            
        BEGIN
            
            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pGetInvoiceDetail.EstablecerInfoSalida',4);
            
            nuPos := tblCurDetFacWeb.COUNT;
            
            nuIdxDet := tbDetFactWeb.first;

            loop
                
                exit when nuIdxDet is null;
                
                -- Inicializa coleccion
                tblCurDetFacWeb(nuPos).sbGrupoServ    := null;
                tblCurDetFacWeb(nuPos).sbServicio     := null;
                tblCurDetFacWeb(nuPos).nuValorCuenta  := null;
                tblCurDetFacWeb(nuPos).sbUnidMedi     := null;
                tblCurDetFacWeb(nuPos).nuConsFactMes1 := null;
                tblCurDetFacWeb(nuPos).nuConsFactMes2 := null;
                tblCurDetFacWeb(nuPos).nuConsFactMes3 := null;
                tblCurDetFacWeb(nuPos).nuMesCons1     := null;
                tblCurDetFacWeb(nuPos).nuAnoCons1     := null;
                tblCurDetFacWeb(nuPos).nuMesCons2     := null;
                tblCurDetFacWeb(nuPos).nuAnoCons2     := null;
                tblCurDetFacWeb(nuPos).nuMesCons3     := null;
                tblCurDetFacWeb(nuPos).nuAnoCons3     := null;              
                
                -- Set de datos
                tblCurDetFacWeb(nuPos).sbGrupoServ   := tbDetFactWeb(nuIdxDet).sbGrupoServ;
                tblCurDetFacWeb(nuPos).sbServicio    := tbDetFactWeb(nuIdxDet).sbServicio;
                tblCurDetFacWeb(nuPos).nuValorCuenta := tbDetFactWeb(nuIdxDet).nuValorCuenta;
                
                -- si existe consumo primera factura
                if( tbDetFactWeb(nuIdxDet).tbConsumos.exists(1) ) then
                    tblCurDetFacWeb(nuPos).sbUnidMedi     := tbDetFactWeb(nuIdxDet).tbConsumos(1).sbUnidMedi;
                    tblCurDetFacWeb(nuPos).nuMesCons1     := tbDetFactWeb(nuIdxDet).tbConsumos(1).nuMes;
                    tblCurDetFacWeb(nuPos).nuAnoCons1     := tbDetFactWeb(nuIdxDet).tbConsumos(1).nuAno;
                    tblCurDetFacWeb(nuPos).nuConsFactMes1 := tbDetFactWeb(nuIdxDet).tbConsumos(1).nuConsumo;                    
                end if;

                -- si existe consumo segunda factura
                if( tbDetFactWeb(nuIdxDet).tbConsumos.exists(2) ) then
                    tblCurDetFacWeb(nuPos).nuMesCons2     := tbDetFactWeb(nuIdxDet).tbConsumos(2).nuMes;
                    tblCurDetFacWeb(nuPos).nuAnoCons2     := tbDetFactWeb(nuIdxDet).tbConsumos(2).nuAno;
                    tblCurDetFacWeb(nuPos).nuConsFactMes2 := tbDetFactWeb(nuIdxDet).tbConsumos(2).nuConsumo;
                    if(tblCurDetFacWeb(nuPos).sbUnidMedi is null) then
                        tblCurDetFacWeb(nuPos).sbUnidMedi     := tbDetFactWeb(nuIdxDet).tbConsumos(2).sbUnidMedi;
                    end if;
                end if;
                
                -- si existe consumo segunda factura
                if( tbDetFactWeb(nuIdxDet).tbConsumos.exists(3) ) then
                    tblCurDetFacWeb(nuPos).nuMesCons3     := tbDetFactWeb(nuIdxDet).tbConsumos(3).nuMes;
                    tblCurDetFacWeb(nuPos).nuAnoCons3     := tbDetFactWeb(nuIdxDet).tbConsumos(3).nuAno;
                    tblCurDetFacWeb(nuPos).nuConsFactMes3 := tbDetFactWeb(nuIdxDet).tbConsumos(3).nuConsumo;
                    if(tblCurDetFacWeb(nuPos).sbUnidMedi is null) then
                        tblCurDetFacWeb(nuPos).sbUnidMedi     := tbDetFactWeb(nuIdxDet).tbConsumos(3).sbUnidMedi;
                    end if;
                end if;
                
                nuPos := nuPos + 1;
                tblCurDetFacWeb.EXTEND(1,1);
                
                nuIdxDet := tbDetFactWeb.next(nuIdxDet);

            end loop;
            
            Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pGetInvoiceDetail.EstablecerInfoSalida',4);
            
        EXCEPTION
            WHEN LOGIN_DENIED or pkConstante.exERROR_LEVEL2  THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.EstablecerInfoSalida',4);
                RAISE;
            WHEN OTHERS THEN
                pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail.EstablecerInfoSalida',4);
                RAISE_APPLICATION_ERROR( pkConstante.nuERROR_LEVEL2, sbErrMsg );
        END EstablecerInfoSalida;
        
        
    BEGIN
        
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.pGetInvoiceDetail',3);
        
        -- Inicializa variables
        Initialize;
        
        -- Valida que exista la factura
        pktblfactura.acckey(inuFactcodi);
        
        -- Procesa la factura
        ProcesarFactura(inuFactcodi);  
        
        -- establecer informacion salida
        EstablecerInfoSalida;
        
        -- Elimina el ultimo reg sin datos
        tblCurDetFacWeb.DELETE(tblCurDetFacWeb.COUNT);
        
        -- <Com>Obtiene Cursor con Datos de Salida</Com>
        IF (tblCurDetFacWeb.COUNT > 0 ) THEN

            OPEN orcRecordSet FOR
            SELECT sbGrupoServ,
                   sbServicio,
                   sbUnidMedi,
                   nuAnoCons1,
                   nuMesCons1,
                   nuConsFactMes1,
                   nuAnoCons2,
                   nuMesCons2,
                   nuConsFactMes2,
                   nuAnoCons3,
                   nuMesCons3,
                   nuConsFactMes3,
                   nuValorCuenta
            FROM TABLE(CAST(tblCurDetFacWeb AS epm_tyDetFacWeb));

        END IF;
        
        -- inicializa cursores de salida ( si no se han abierto)
        InitializeDetCursor(orcRecordSet);
        
        Pkg_Epm_Utilidades.Trace_SetMsg('Termina pkg_Epm_WebCoupon.pGetInvoiceDetail',3);
        
    EXCEPTION
        WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail',3);
            InitializeDetCursor(orcRecordSet);
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMsg);
        WHEN OTHERS THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.pGetInvoiceDetail',3);
            InitializeDetCursor(orcRecordSet);
            pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMsg);
    END pGetInvoiceDetail;

    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> pGetServicesByAddress </Unidad>
    <Descripcion>
        Permite retornar por contrato asociado a una dirección, los grupos de servicios
        asociados al mismo, Ejemplo:

        123|CL 50 CR 50 -50|ENERGIA, AGUAS, GAS, OTROS
        123456|CL 50 CR 50 -50|OTROS
        12444|CL 50 CR 50 -50|AGUAS
    </Descripcion>
    <Autor> Ronald Eduardo Olarte - AXEDE S.A </Autor>
    <Fecha>  27/01/2016 </Fecha>
    <Parametros>
    <param nombre="isbPais" tipo="VARCHAR2(3)" Direccion="IN" >Pais</param>
    <param nombre="inuDepartamento" tipo="NUMBER(4,0)" Direccion="IN" >Departamento</param>
    <param nombre="inuMunicipio" tipo="NUMBER(6,0)" Direccion="IN" >Municipio</param>
    <param nombre="isbDireccion" tipo="VARCHAR2(200)" Direccion="IN" >Direccion</param>
    <param nombre="orcProductos" tipo="REF CURSOR" Direccion="OUT" >Valores de las deudas de los productos asociados a la dirección</param>
    <param nombre="onuCodigoError" tipo="NUMBER(15,0)" Direccion="OUT" >Código de Error</param>
    <param nombre="osbMensajeError" tipo="VARCHAR2" Direccion="OUT" >Mensaje de Error</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="rolartep" Fecha="27-01-2016" Inc="OC554300">
         Creación
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    PROCEDURE pGetServicesByAddress
    (
        isbPais             IN    GST_PAIS.PAISCODI%TYPE,
        inuDepartamento     IN    NUMBER,
        inuMunicipio        IN    NUMBER,
        isbDireccion        IN    AB_ADDRESS.ADDRESS_PARSED%TYPE,
        orcRecordSet        OUT   SYS_REFCURSOR,
        onuCodigoError      OUT   pkg_epm_utilidades.tyCodigoError,
        osbMensajeError     OUT   pkg_epm_utilidades.tyMensajeError
    )
    IS

        -- Productos por instalacion
        CURSOR cuProdsInstalacion
        (
            isbInstal   IN  AB_ADDRESS.CADASTRAL_ID%TYPE
        )
        IS
        SELECT sesususc, sesunuse, sesuserv, sesuesco
        FROM   servsusc, epm_servempr, pr_product pr , ab_address dir
        WHERE  dir.cadastral_id = isbInstal
        AND    dir.address_id = pr.address_id
        AND    pr.product_id = sesunuse
        AND    sesuserv = epm_servempr.seemserv
        AND    epm_servempr.seemclas <> 1
        ORDER BY sesususc ASC, sesuserv ASC;
        
        -- grupo se servicio 
        CURSOR cuGrupoServ
        (
            inuServicio in servsusc.sesuserv%type
        )
        IS
        select NVL(segfgrse, -1) segfgrse
        from   epm_servgrfw
        where  segfserv = inuServicio;

        TYPE tyrcGrupoServ IS RECORD
        (
            nuContrato      SERVSUSC.SESUSUSC%TYPE,
            sbDireccion     ADDRPARS.ADPAADPA%TYPE,
            sbGrupoServ     VARCHAR2(2000)
        );
        
        TYPE tytbGrupoServ IS TABLE OF tyrcGrupoServ INDEX BY VARCHAR2(200);        
        tbGrupoServ     tytbGrupoServ;

        tbGeneral                  epm_tyGeneral;
        tbGeneral_Empty            epm_tyGeneral := epm_tyGeneral(epm_tyObjGeneral);

        -- tipo tabla prods por direccion
        TYPE tytbProdInstal IS TABLE OF cuProdsInstalacion%ROWTYPE INDEX BY BINARY_INTEGER;

        -- tabla productos por instalacion
        tbProdInstal    tytbProdInstal;

        -- indices tablas
        nuIdxProd        binary_integer;
        nuPos            NUMBER;

        nuErrorCode            pkg_epm_utilidades.tyCodigoError;
        sbErrorMess            pkg_epm_utilidades.tyMensajeError;
        
        sbIndex                VARCHAR2(200); 
        sbGrupServ             VARCHAR2(2000);
        nuGrupServ             NUMBER;
        
        nuContrato             NUMBER := NULL; 
        
        nuIDunicoMP            NUMBER := NULL;
        rcInfoDireccion        pkg_epm_Direccion_MP.rc_info_dir := NULL;

        PROCEDURE Initialize
        IS
        BEGIN

            pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.pGetServicesByAddress.Initialize',4);

            --  Inicializa código de mensaje de error
            onuCodigoError := pkConstante.EXITO;

            --  Inicializa descripción del mensaje de error
            osbMensajeError := NULL;

            nuErrorCode := pkConstante.EXITO;
            sbErrorMess := NULL;
            
            tbGrupoServ.delete;

            pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pGetServicesByAddress.Initialize',4);

        EXCEPTION
            WHEN EPM_errors.EX_CTRLERROR THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress.Initialize', 4);
                RAISE;
            WHEN OTHERS THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress.Initialize', 4);
                Epm_Errors.SetError;
                RAISE EPM_errors.EX_CTRLERROR;
        END Initialize;

        -- Realiza inicialización de cursor referenciado si no se encuentra abierto
        PROCEDURE pInitializeCursor
        (
            orcProductos IN OUT SYS_REFCURSOR
        )
        IS
        BEGIN

            pkg_epm_utilidades.trace_setmsg ('Inicia pkg_Epm_WebCoupon.pGetServicesByAddress.pInitializeCursor', 4);

            -- Si esta abierto el cursor referenciado se cierra
            IF ( orcProductos%ISOPEN ) THEN
                CLOSE orcProductos;
            END IF;

            -- Se inicializa el objeto
            tbGeneral := tbGeneral_Empty;
            tbGeneral.DELETE(tbGeneral.COUNT);

            OPEN orcProductos FOR
            SELECT nuCampo01        CONTRATO,
                   sbCampo01        DIRECCION,                   
                   sbCampo02        GRUPOSERVICIO
              FROM TABLE (CAST(tbGeneral AS epm_tyGeneral));

            pkg_epm_utilidades.trace_setmsg ('Finaliza pkg_Epm_WebCoupon.pGetServicesByAddress.pInitializeCursor', 4);

        EXCEPTION
            WHEN EPM_errors.EX_CTRLERROR THEN
                pkg_epm_utilidades.trace_setmsg ('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress.pInitializeCursor', 4);
                RAISE;
            WHEN OTHERS THEN
                pkg_epm_utilidades.trace_setmsg ('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress.pInitializeCursor', 4);
                EPM_errors.SetError;
                RAISE EPM_errors.EX_CTRLERROR;
        END pInitializeCursor;

        PROCEDURE ValInputData
        IS
        BEGIN

            pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.pGetServicesByAddress.ValInputData',4);

            --  Valida el departamento
            Pkg_Epm_Boubicacion_Geografica.pValidExistDeparta(inuDepartamento);

            --  Valida la localidad
            Pkg_Epm_Boubicacion_Geografica.pValidExistLocalida( inuDepartamento, inuMunicipio );

            pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.pGetServicesByAddress.ValInputData',4);

        EXCEPTION
            WHEN EPM_errors.EX_CTRLERROR THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress.ValInputData', 4);
                RAISE;
            WHEN OTHERS THEN
                Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress.ValInputData', 4);
                Epm_Errors.SetError;
                RAISE EPM_errors.EX_CTRLERROR;
        END ValInputData;

    BEGIN

        Pkg_Epm_Utilidades.Trace_SetMsg('Inicio pkg_Epm_WebCoupon.pGetServicesByAddress', 3);

        -- Inicializa variables
        Initialize;

        -- Valida Datos Entrada
        ValInputData;

        -- Inicializa cursor
        pInitializeCursor(orcRecordSet);

        -- Se inicializa el objeto
        tbGeneral := tbGeneral_Empty;

        -- Obtiene la Información de la dirección
        Pkg_EPM_Direcciones.pObtenerRecordInfoDir
        (
            nuIDunicoMP,
            pkg_epm_direcciones.cnuPAIS_COLOMBIA,
            inuDepartamento,
            inuMunicipio,
            isbDireccion,
            rcInfoDireccion,
            nuErrorCode,
            sbErrorMess
        );


        pkg_epm_utilidades.EvaluarErrorExterno(nuErrorCode,sbErrorMess);

        Pkg_Epm_Utilidades.Trace_SetMsg('nuPagina: '||rcInfoDireccion.CodInstalacion, 3);

        -- Obtiene los productos asociados a la instalacion
        open  cuProdsInstalacion(rcInfoDireccion.CodInstalacion);
        fetch cuProdsInstalacion bulk collect into tbProdInstal;
        close cuProdsInstalacion;

        -- recorre los productos de la instalacion
        nuIdxProd := tbProdInstal.first;

        -- Inicializa variables
        sbGrupServ := null;
        nuGrupServ := null;

        loop

            exit when nuIdxProd is null;

            -- Inicializa variables
            nuPos      := tbGeneral.COUNT;

            -- Inicializa variables
            sbGrupServ := null;
            nuGrupServ := null;

            -- Obtiene el grupo al que pertenece el producto
            open  cuGrupoServ(tbProdInstal(nuIdxProd).sesuserv);
            fetch cuGrupoServ into nuGrupServ;
            close cuGrupoServ;

            -- si no existe grupo de servicio
            if( nuGrupServ is null ) then
                -- asigna el otros grupos
                sbGrupServ  := 'OTROS';
            else
                -- Obtiene la descripcion del grupo de servicios
                sbGrupServ := pktblepm_grupsefw.frcGetRecord(nuGrupServ).grsfdesc;
            end if;

            sbIndex := tbProdInstal(nuIdxProd).sesususc;

            -- valida si no se ha consultado grupo de servicio
            if( NOT tbGrupoServ.exists(sbIndex)) then

                -- almacena la configuracion del grupo de servicio
                tbGrupoServ(sbIndex).nuContrato  := tbProdInstal(nuIdxProd).sesususc;
                tbGrupoServ(sbIndex).sbDireccion := rcInfoDireccion.Nomenclatura;
                tbGrupoServ(sbIndex).sbGrupoServ := sbGrupServ;

            else

                if ( instr( ','||tbGrupoServ(sbIndex).sbGrupoServ||',', ','||sbGrupServ||',' ) = 0 ) then
                    -- almacena la configuracion del grupo de servicio
                    tbGrupoServ(sbIndex).nuContrato  := tbProdInstal(nuIdxProd).sesususc;
                    tbGrupoServ(sbIndex).sbDireccion := rcInfoDireccion.Nomenclatura;
                    tbGrupoServ(sbIndex).sbGrupoServ := sbGrupServ ||','|| tbGrupoServ(sbIndex).sbGrupoServ;
                end if;

            end if;

            nuIdxProd := tbProdInstal.next(nuIdxProd);

        end loop;

        -- Obtiene Cursor con Datos de Salida
        IF (tbGrupoServ.COUNT > 0 ) THEN

            sbIndex := tbGrupoServ.FIRST;
            nuPos   := tbGeneral.COUNT;

            LOOP
                EXIT WHEN sbIndex IS NULL;

                tbGeneral(nuPos).nuCampo01 := tbGrupoServ(sbIndex).nuContrato;
                tbGeneral(nuPos).sbCampo01 := tbGrupoServ(sbIndex).sbDireccion;
                tbGeneral(nuPos).sbCampo02 := tbGrupoServ(sbIndex).sbGrupoServ;

                nuPos := nuPos + 1;
                tbGeneral.EXTEND(1,1);

                sbIndex := tbGrupoServ.NEXT(sbIndex);
            END LOOP;

            -- Si esta abierto el cursor referenciado se cierra
            IF ( orcRecordSet%ISOPEN ) THEN
                CLOSE orcRecordSet;
            END IF;

            tbGeneral.DELETE(tbGeneral.COUNT);

            OPEN orcRecordSet FOR
            SELECT nuCampo01        CONTRATO,
                   sbCampo01        DIRECCION,
                   sbCampo02        GRUPOSERVICIO
            FROM TABLE(CAST(tbGeneral AS epm_tyGeneral));

        END IF;

        -- inicializa cursores de salida ( si no se han abierto)
        InitCursorGrupoServDir(orcRecordSet);

        Pkg_Epm_Utilidades.Trace_SetMsg('Fin pkg_Epm_WebCoupon.pGetServicesByAddress', 3);

    EXCEPTION
        WHEN EPM_errors.EX_CTRLERROR THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress', 3);
            InitCursorGrupoServDir(orcRecordSet);
            Epm_Errors.GetError(onuCodigoError, osbMensajeError);
        WHEN OTHERS THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.pGetServicesByAddress', 3);
            InitCursorGrupoServDir(orcRecordSet);
            Epm_Errors.SetError;
            Epm_Errors.GetError(onuCodigoError, osbMensajeError);
    END pGetServicesByAddress;

    /*
    <Procedure Fuente="Propiedad Intelectual de EEPP de Medellin (c)">
    <Unidad>fsbGetPagado</Unidad>
    <Descripcion>
    Retorna flag indicador de cupon pagado.
    </Descripcion>
    <Autor>lcruzp Axede S.A</Autor>
    <Fecha>30-08-2018</Fecha>
    <Retorno Nombre = "sbPagado" Tipo = "VARCHAR2">
    S/N.
    </Retorno>
    <Parametros>
        <param nombre="inuCupon" tipo="cupon.cuponume%TYPE" direccion="IN">Numero del Cupon.</param>
    </Parametros>
    <Historial>
        <Modificacion Autor="lcruzp" Fecha="30-08-2018" Inc="OC806504">
        Creación del Método.
        </Modificacion>
    </Historial>
    </Procedure>
    */

    FUNCTION fsbGetPagado
    (
        inuCupon  IN CUPON.CUPONUME%TYPE
    )
    RETURN CUPON.CUPOFLPA%TYPE
    IS
    
        sbPagado        CUPON.CUPOFLPA%TYPE;
        nuCupon         CUPON.CUPONUME%TYPE;
        nuCuponPadre    CUPON.CUPONUME%TYPE;
        nuCuponHijo     CUPON.CUPONUME%TYPE;        

        CURSOR cuPagado (inuCupon  IN CUPON.CUPONUME%TYPE) IS
        SELECT pagocupo
          FROM pagos
         WHERE pagocupo = inuCupon;

        CURSOR cuHijoPagado (inuCupon  IN CUPON.CUPONUME%TYPE) IS
        SELECT cupocupa
          FROM pagos, cupon
         WHERE cupocupa = inuCupon
           AND cuponume = pagocupo;
           
        CURSOR cuPapaPagado (inuCupon  IN CUPON.CUPONUME%TYPE) IS
        SELECT cuponume
          FROM pagos, cupon
         WHERE cuponume = inuCupon
           AND pagocupo = cupocupa;

    BEGIN
        pkErrors.Push('pkg_Epm_WebCoupon.fsbGetPagado');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicio pkg_Epm_WebCoupon.fsbGetPagado', 3);

        -- <Com>Inicializa variable de salida.</Com>
        -- Inicializa variables
        sbPagado := 'N';
        
        -- <Com>Valida y obtiene informacion del registro de pago cupon.</Com>
        OPEN cuPagado (inuCupon);
        FETCH cuPagado INTO nuCupon;
        CLOSE cuPagado;

        DBMS_OUTPUT.PUT_LINE('--> inuCupon: '||inuCupon||' - '||nuCupon||' - '||nuCuponPadre);

        IF (NVL(nuCupon, -1) = inuCupon) THEN
            sbPagado := 'S';
        ELSE
            -- Si es un cupon padre
            IF ( NVL(pktblCupon.fnuGetCupoCupa(inuCupon), -1) = -1 ) THEN
                -- <Com>Valida y obtiene informacion del registro de pago cupon hijo.</Com>
                OPEN cuHijoPagado (inuCupon);
                FETCH cuHijoPagado INTO nuCuponPadre;
                CLOSE cuHijoPagado;

                IF (NVL(nuCuponPadre, -1) = inuCupon) THEN
                    sbPagado := 'X';
                END IF;
                
            ELSE
                -- El cupon es hijo
                -- <Com>Valida y obtiene informacion del registro de pago cupon papa.</Com>
                OPEN cuPapaPagado (inuCupon);
                FETCH cuPapaPagado INTO nuCuponHijo;
                CLOSE cuPapaPagado;

                IF (NVL(nuCuponHijo, -1) = inuCupon) THEN
                    sbPagado := 'X';
                END IF;

            END IF;

        END IF;

        Pkg_Epm_Utilidades.Trace_SetMsg('Fin pkg_Epm_WebCoupon.fsbGetPagado', 3);
        pkErrors.Pop;

        RETURN sbPagado;

    EXCEPTION
        WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fsbGetPagado',3);
            pkErrors.Pop;
            RAISE;
        WHEN OTHERS THEN
            pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.fsbGetPagado',3);
            pkErrors.Pop;
            RAISE;
    END fsbGetPagado;

    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> ColecConsulta </Unidad>
    <Descripcion>
        Permite coleccionar en una tabla PL el volcado de los datos del cursor
        referenciado.
    </Descripcion>
    <Autor> lcruzp - AXEDE S.A </Autor>
    <Fecha> 30-08-2018 </Fecha>
    <Parametros>
    <param nombre="ircRecordSet" tipo="REF CURSOR" Direccion="IN" >Cupones para pago</param>
    <param nombre="inuIndice" tipo="NUMBER" Direccion="IN" >Indice inicial</param>
    <param nombre="onuIndice" tipo="NUMBER" Direccion="OUT" >Indice incrementado</param>
    <param nombre="onuCodigoError" tipo="NUMBER" Direccion="OUT" >Codigo de Error</param>
    <param nombre="osbMensajeError" tipo="VARCHAR2" Direccion="OUT" >Mensaje de Error</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="lcruzp" Fecha="30-08-2018" Inc="OC806504">
         Creación
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    ----------------------------------------------
    -- ColecConsulta
    ----------------------------------------------
    PROCEDURE ColecConsulta
    (
        ircRecordSet      IN   SYS_REFCURSOR,
        inuIndice         IN   NUMBER,
        onuIndice         OUT  NUMBER,
        onuCodigoError    OUT  Pkg_Epm_Utilidades.tycodigoerror,
        osbMensajeError   OUT  Pkg_Epm_Utilidades.tymensajeerror
    )
    IS
    
        nuIndice            NUMBER;
        rcDatos             tyrcDatos;
        -- rcRecordSet     SYS_REFCURSOR;
    BEGIN

        pkErrors.Push('pkg_Epm_WebCoupon.ColecConsulta');
        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.ColecConsulta',3);

        -- <Com>Inicializa variables de error.</Com>
        InicializarErr(onuCodigoError, osbMensajeError);

        nuIndice := inuIndice;
        -- <Com>Volca la informacion del cursor referenciado en la tabla PL de salida.</Com>
        FETCH ircRecordSet INTO rcDatos;

        IF (rcDatos.NumeroCupon IS NOT NULL) THEN

           LOOP
               EXIT WHEN ircRecordSet%NOTFOUND;

               nuIndice := nuIndice + 1;
               gtbGeneral(nuIndice).nuCampo01 := rcDatos.NumeroCupon;
               gtbGeneral(nuIndice).nuCampo02 := rcDatos.Contrato;
               gtbGeneral(nuIndice).nuCampo03 := rcDatos.CodigoFactura;
               gtbGeneral(nuIndice).nuCampo04 := rcDatos.ValorCupon;
               gtbGeneral(nuIndice).dtCampo01 := rcDatos.FechaPago;
               gtbGeneral(nuIndice).dtCampo02 := rcDatos.FinalPago;
               gtbGeneral(nuIndice).nuCampo05 := rcDatos.Saldo;
               gtbGeneral(nuIndice).sbCampo01 := rcDatos.TipoCupon;

               gtbGeneral.EXTEND(1, 1);

               FETCH ircRecordSet INTO rcDatos;
           END LOOP;

        END IF;

        IF (nuIndice > 0 AND rcDatos.NumeroCupon IS NOT NULL) THEN
            nuIndice := gtbGeneral.COUNT - 1;
        END IF;

        DBMS_OUTPUT.PUT_LINE('nuIndice: '||nuIndice);
        IF (nuIndice > 0) THEN
            DBMS_OUTPUT.PUT_LINE('Cupon factura: '||gtbGeneral(nuIndice).nuCampo01);
        ELSE
            DBMS_OUTPUT.PUT_LINE('--> No hay cupon de factura disponible');
        END IF;

        onuIndice := nuIndice;
        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.ColecConsulta',4);
        pkErrors.Pop;

    EXCEPTION
        WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ColecConsulta',3);
            pkErrors.Pop;
            pkErrors.GetErrorVar (onuCodigoError, osbMensajeError);
        WHEN OTHERS THEN
            pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con errores pkg_Epm_WebCoupon.ColecConsulta',3);
            pkErrors.Pop;
            RAISE_APPLICATION_ERROR (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END ColecConsulta;
    
    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> InicializarErr </Unidad>
    <Descripcion>
        Inicializa variables de error
    </Descripcion>
    <Autor> lcruzp - AXEDE S.A </Autor>
    <Fecha> 30-08-2018 </Fecha>
    <Parametros>
    <param nombre="onuCodigoError" tipo="NUMBER" Direccion="OUT" >Codigo de Error</param>
    <param nombre="osbMensajeError" tipo="VARCHAR2" Direccion="OUT" >Mensaje de Error</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="lcruzp" Fecha="30-08-2018" Inc="OC806504">
         Creación
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    PROCEDURE InicializarErr
    (
        onuCodigoError  OUT Pkg_Epm_Utilidades.TYCODIGOERROR,
        osbMensajeError OUT Pkg_Epm_Utilidades.TYMENSAJEERROR
    )
    IS
    BEGIN

        Pkg_Epm_Utilidades.Trace_SetMsg('Inicia pkg_Epm_WebCoupon.InicializarErr',4);

        -- pkErrors.Initialize;
        onuCodigoError  := pkConstante.EXITO;
        osbMensajeError := pkConstante.NULLSB;

        Pkg_Epm_Utilidades.Trace_SetMsg('Finaliza pkg_Epm_WebCoupon.InicializarErr',4);

    EXCEPTION
        WHEN LOGIN_DENIED OR Epm_Errors.EX_CTRLERROR THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.InicializarErr', 4);
            RAISE;
        WHEN OTHERS THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.InicializarErr', 4);
            Epm_Errors.SetError;
            RAISE Epm_Errors.EX_CTRLERROR;
    END InicializarErr;
    
     
    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> fnuObtValFactura </Unidad>
    <Descripcion>
       Obtiene el Valor Total de la Factura - Valor de Notas Generadas por Concepto de Anulación de Pagos.
    </Descripcion>
    <Autor> VJIMENEC - MVM Ingenieria de Software S.A.S </Autor>
    <Fecha> 04-12-2018 </Fecha>
    <Parametros>
    <param nombre="ircRecordSet" tipo="REF CURSOR" Direccion="IN" >Cupones para pago</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="DHURTADP" Fecha="21-02-2018" Inc="WO0000000478243">
         Se modifica la consulta para reemplazar el split por instr.
    </Modificacion>
    <Modificacion Autor="VJIMENEC" Fecha="03-12-2018" Inc="OC830725">
         Creación
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    FUNCTION fnuObtValFactura (inuFactura FACTURA.FACTCODI%TYPE)
    RETURN NUMBER
    IS   
            sbCausasRestaFactura    EPM_PARAMETR.VALUE%TYPE := pkg_epm_boparametr.fsbget('EPM_CAUSACARGO_RESTA_FACTURA');
            nuValorFactura  NUMBER:=0;
            nuValorRestar   NUMBER:=0;
    BEGIN
            
            --Obtiene Valor de la Factura
            nuValorFactura := pkBCAccountStatus.fnuGetTotalValue(inuFactura);
            
            --Obtiene Valor de los Cargos que deben Ser Restados del Total (Seguin Causa de Cargo Configuradas)
            WITH CUENTAS 
                AS 
                (
                        SELECT CUCOCODI
                           FROM CUENCOBR
                         WHERE CUCOFACT = inuFactura
                 )
            SELECT NVL (SUM (DECODE (CARGSIGN, 'DB', CARGVALO, -CARGVALO)), 0) INTO nuValorRestar
              FROM CUENTAS, CARGOS
           WHERE CARGCUCO = CUCOCODI 
                AND CARGSIGN || '' IN ('DB', 'CR')
                AND instr(','||sbCausasRestaFactura||',',','||CARGCACA||',') > 0;              
                                   
            --Retorna Valor Total Calculado
            RETURN (NVL(nuValorFactura,0) - NVL(nuValorRestar,0));
    
    EXCEPTION
        WHEN LOGIN_DENIED OR Epm_Errors.EX_CTRLERROR THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.fnuObtValFactura', 4);
            RAISE;
        WHEN OTHERS THEN
            Pkg_Epm_Utilidades.Trace_SetMsg('Fin con error pkg_Epm_WebCoupon.fnuObtValFactura', 4);
            Epm_Errors.SetError;
            RAISE Epm_Errors.EX_CTRLERROR;    
    END fnuObtValFactura;
    
        
    /**************************************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Empresas Publicas de Medellin">
    <Unidad> pIniCursorValorHora </Unidad>
    <Descripcion>
        Inicializa cursor ref valores hora
    </Descripcion>
    <Autor> Tulio Ruiz - MVM </Autor>
    <Fecha>  29/11/2018 </Fecha>
    <Parametros>
    <param nombre="ORFORDENES" tipo="REF CURSOR" Direccion="IN/OUT" >Cursor Ref Ordenes</param>
    </Parametros>
    Historia de Modificaciones
    <Historial>
    <Modificacion Autor="truizdia" Fecha="29/11/2018 " Inc="OCXXXXXX">
         Creacion
    </Modificacion>
    </Historial>
    </Procedure>
    *******************************************************************************/
    PROCEDURE pIniCursorValorHora
    (
        orfValoresHora IN OUT SYS_REFCURSOR
    )
    IS
        csbMT_NAME  CONSTANT VARCHAR2(50) := 'pIniCursorValorHora';
        
        tbGeneral           epm_tyGeneral;
        tbGeneral_Empty     epm_tyGeneral := epm_tyGeneral(epm_tyObjGeneral);
        
    BEGIN
            
        Pkg_Epm_Utilidades.Trace_SetMsg(csbSP_NAME||csbMT_NAME, cnuNVLTRC, csbPUSH);

        -- Si esta abierto el cursor referenciado se cierra
        IF ( orfValoresHora%ISOPEN ) THEN
            CLOSE orfValoresHora;
        END IF;
            
        -- Se inicializa el objeto
        tbGeneral := tbGeneral_Empty;
        tbGeneral.DELETE(tbGeneral.COUNT);

        OPEN orfValoresHora FOR
        SELECT 
            nuCampo01 SERVICIO_SUSCRITO,
            dtCampo01 FECHA_DE_EXCEDENTE,
            nuCampo02 HORA_DE_EXCEDENTE,
            sbCampo01 TIPO_DE_CONSUMO,
            nuCampo03 NUMERO_UNIDADES_EXCEDENTE,
            nuCampo04 PRECIO_BOLSA,
            nuCampo05 VALOR_UNIDADES_EXCEDENTE,
            nuCampo06 PERIODO_DE_CONSUMO,
            dtCampo02 FECHA_INI_PERICONSUMO,
            dtCampo03 FECHA_FIN_PERICONSUMO
          FROM TABLE (CAST(tbGeneral AS epm_tyGeneral));

        Pkg_Epm_Utilidades.Trace_SetMsg(csbSP_NAME||csbMT_NAME, cnuNVLTRC, csbPOP);
            
    EXCEPTION
        WHEN EPM_errors.EX_CTRLERROR THEN
            Pkg_Epm_Utilidades.Trace_SetMsg(csbSP_NAME||csbMT_NAME, cnuNVLTRC, csbPOP_ERC);
            RAISE;
        WHEN OTHERS THEN
            Pkg_Epm_Utilidades.Trace_SetMsg(csbSP_NAME||csbMT_NAME, cnuNVLTRC, csbPOP_ERR);
            EPM_errors.SetError;
            RAISE EPM_errors.EX_CTRLERROR;
    END pIniCursorValorHora;
    
    /*************************************************************************
    Unidad      : GetExcedentesEnergia
    Descripción : Liquidate exported units above imported units using
                  marginal prices. Example:
    *************************************************************************/
    PROCEDURE GetExcedentesEnergia
    (
        inuContrato     IN  servsusc.sesususc%type,
        inuPeriodFact   IN  perifact.pefacodi%type,
        orfValoresHora  OUT pkConstante.tyrefcursor,
        onuCodigoError  OUT Pkg_Epm_Utilidades.TYCODIGOERROR,
        osbMensajeError OUT Pkg_Epm_Utilidades.TYMENSAJEERROR
    )
    IS
    
        csbMT_NAME  CONSTANT VARCHAR2(50) := 'GetExcedentesEnergia';
    
        nuProduct         gc_consmeho.comhsesu%type;
        nuPeriodoCons     gc_consmeho.comhpeco%type;
        
        onuUnitsExp2      cargos.cargunid%type;
        onuValueExp2      cargos.cargvalo%type;
        
        nuTotalUnits    gc_consmeho.comhunco%type;
        tbExpEnergy     PE_BOMarginalPrices.tytbPricesLiq;
        
        /* Monthly usage */
        nuConsumoPeri        conssesu.cosscoca%type;

        
        dtInitDate          pericose.pecsfeci%type;
        dtFinlDate          pericose.pecsfeci%type;
        
        inuCiclo            servsusc.sesucicl%type;   
        onuPeriodoc         pericose.pecscons%type;
        nuTipoConsImp       gc_consmeho.comhtcon%type;
        nuTipoConsExp       gc_consmeho.comhtcon%type;
        nuConcepto          concepto.conccodi%type;
        sbTipoCons          tipocons.tcondesc%type;
  
        tbCateTipoProd      pkg_EPM_Utilidades.tyTabla;
        tbDetalle           pkg_EPM_Utilidades.tyTabla;
        nuIdx               BINARY_INTEGER;
        
        tbValoresHora       tytbValorHora; 
        tbFecConsEx         tytbFecConsEx;    
        
        nuContador          NUMBER:=1;
        
        sbIdxVal            VARCHAR2(50);
        sbIdxValTot         VARCHAR2(50);
        
        -- tabla general datos
        tbGeneral           epm_tyGeneral;
        tbGeneral_Empty     epm_tyGeneral := epm_tyGeneral(epm_tyObjGeneral);
          
        CURSOR cuProdCont
        (
           inuContratoP       IN  servsusc.SESUSUSC%TYPE
        )
        IS
        SELECT   sesunuse, sesususc,sesuserv, sesuplfa,sesucico,sesucicl
          FROM   servsusc
         WHERE   sesususc =     inuContratoP             
         AND     instr(','||csbEPM_IMP_PLAN_CREG030||',',','||sesuplfa||',') > 0;
        
        CURSOR cuPeriConsxPeriFact
        (
           inuProducto       IN  servsusc.sesunuse%TYPE,
           inuPeriFact       IN  conssesu.cosspefa%TYPE
        )
        IS
        SELECT distinct cosspecs
        FROM   conssesu
        WHERE  cosssesu = inuProducto
        AND    cosspefa = inuPeriFact
        AND    cossmecc = CM_BOConstants.fnuGetMECC_FACTURADO
        AND    cossflli = 'S';
                                  
                                          
        -- Registro Cursor
        rcProdCont        cuProdCont%ROWTYPE; 
                                                                 
        /************************************************************************* 
        Parámetros:
        
            inuConsPeriod   Usage period
            inuConcept      Liquidated concept
            odtInitDate     Initial Date
            odtFinlDate     Final date
        *************************************************************************/
        PROCEDURE GetPeriodDates
        (
            inuConsPeriod   in  gc_consmeho.comhpeco%type,
            inuConcept      in  concepto.conccodi%type,
            odtInitDate     out pericose.pecsfeci%type,
            odtFinlDate     out pericose.pecsfeci%type
        )
        IS
            /* Concept */
            rcConcept   concepto%rowtype;
        BEGIN
            ut_trace.trace('Init pkg_Epm_WebCoupon.GetExcedentesEnergia.GetPeriodDates ['||inuConsPeriod||']['||inuConcept||']',2);

            /* Get concept */
            pkConceptMgr.GetRecord(inuConcept, rcConcept);

            /* Get period dates */
            FA_BOServiciosLiqPorProducto.ObtFechasPericose
            (
                inuConsPeriod,
                rcConcept.concticc,
                odtInitDate,
                odtFinlDate
            );

            ut_trace.trace('odtInitDate: '||odtInitDate||chr(10)||
                           'odtFinlDate: '||odtFinlDate||chr(10)||
                           'END pkg_Epm_WebCoupon.GetExcedentesEnergia.GetPeriodDates',2);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ut_trace.trace('CONTROLLED_ERROR pkg_Epm_WebCoupon.GetExcedentesEnergia.GetPeriodDates',2);
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('others pkg_Epm_WebCoupon.GetExcedentesEnergia.GetPeriodDates',2);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END GetPeriodDates;
        
        /*************************************************************************
        Parámetros:

            inuProduct      Product id
            idtInitDate     Initial Date
            idtFinlDate     Final date
            inuExpConsType  Consumption type of exported energy
            onuTotalUnits   Total exported units
            otbExpEnergy    Detail of exported units
        *************************************************************************/
        PROCEDURE GetHourlyUsage
        (
            inuProduct      in  gc_consmeho.comhsesu%type,
            idtInitDate     in  pericose.pecsfeci%type,
            idtFinlDate     in  pericose.pecsfeci%type,
            inuExpConsType  in  gc_consmeho.comhtcon%type,
            onuTotalUnits   out gc_consmeho.comhunco%type,
            otbExpEnergy    out nocopy PE_BOMarginalPrices.tytbPricesLiq

        )
        IS
            /* Concept */
            rcConcept   concepto%rowtype;

            /* Hourly units in ranges of 15 minutes */
            rctbConsmeho    pkBCGc_consmeho.tyrcHrlyCons;
            nuIdx           number;
            sbHash          PE_BOMarginalPrices.styVarchar;
            
        BEGIN
            
            ut_trace.trace('Init pkg_Epm_WebCoupon.GetHourlyUsage ['||inuProduct||']['||idtInitDate||
                           ']['||idtFinlDate||']['||inuExpConsType||']',2);
            
            /* Get hourly self-generation exported energy in ranges of 15 minutes */
            FA_BCFreeClientsLiq.GetHrlyConsmptnsRange
            (
                inuProduct,
                inuExpConsType,
                idtInitDate,
                idtFinlDate,
                rctbConsmeho
            );

            /* Reindex and summarize by YYYYMMDDHH24 */
            onuTotalUnits := 0;

            nuIdx := rctbConsmeho.comhfeco.first;

            WHILE (nuIdx IS not null) LOOP

                /* Get hash */
                sbHash :=   to_char(rctbConsmeho.comhfeco(nuIdx), PE_BOMarginalPrices.csbDATE_HSH_FM)||
                            to_char(rctbConsmeho.comhhoco(nuIdx), PE_BOMarginalPrices.csbHOUR_HSH_FM);

                /* Get detail by hour */
                IF otbExpEnergy.exists(sbHash) THEN
                    otbExpEnergy(sbHash).comhunco := otbExpEnergy(sbHash).comhunco + rctbConsmeho.comhunco(nuIdx);
                else
                    otbExpEnergy(sbHash).comhunco := rctbConsmeho.comhunco(nuIdx);
                END IF;

                /* Calculate total units */
                onuTotalUnits := onuTotalUnits + rctbConsmeho.comhunco(nuIdx);

                nuIdx := rctbConsmeho.comhfeco.next(nuIdx);
            END LOOP;

            ut_trace.trace('END pkg_Epm_WebCoupon.GetHourlyUsage ['||onuTotalUnits||']',2);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ut_trace.trace('CONTROLLED_ERROR pkg_Epm_WebCoupon.GetHourlyUsage',2);
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('others pkg_Epm_WebCoupon.GetHourlyUsage',2);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END GetHourlyUsage;

        /*************************************************************************
        Parámetros:

            inuConsPeriod   Consumption period
            inuImpConsType  Consumption type of imported energy
            orcProdCons     Imported monthly usage
        *************************************************************************/
        PROCEDURE GetMonthlyUsage
        (
            inuProducto     in  gc_consmeho.comhsesu%type, 
            inuConsPeriod   in  gc_consmeho.comhpeco%type,
            inuImpConsType  in  gc_consmeho.comhtcon%type,
            onuConsumoProd  out number
        )
        IS
           
            CURSOR cuConsumo (inuProducto     in  conssesu.cosssesu%type, 
                              inuConsPeriod   in  conssesu.cosspecs%type,
                              inuImpConsType  in  conssesu.cosstcon%type)
            IS
            SELECT   SUM (cosscoca) consumo
              FROM   conssesu
             WHERE       cosssesu = inuProducto
                     AND cosspecs = inuConsPeriod
                     AND cossmecc = CM_BOConstants.fnuGetMECC_FACTURADO
                     AND cosstcon = inuImpConsType
                     AND cossflli = 'S';
            
        BEGIN
            ut_trace.trace('Init pkg_Epm_WebCoupon.GetMonthlyUsage ['||inuConsPeriod||']['||inuImpConsType||']',2);
          
            -- Datos de Consumo
            IF ( cuConsumo%ISOPEN ) THEN
                CLOSE cuConsumo;
            END IF;
            
            OPEN cuConsumo (inuProducto,inuConsPeriod,inuImpConsType);
            FETCH cuConsumo INTO onuConsumoProd;
            CLOSE cuConsumo;
                                  
            ut_trace.trace('END pkg_Epm_WebCoupon.GetMonthlyUsage ['||onuConsumoProd||']',2);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ut_trace.trace('CONTROLLED_ERROR pkg_Epm_WebCoupon.GetMonthlyUsage',2);
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('others pkg_Epm_WebCoupon.GetMonthlyUsage',2);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END GetMonthlyUsage;

        /*************************************************************************
        Unidad      : LiqExpAboveImp
        Descripción : Liquidate exported units above imported units using
                      marginal prices. Example:
        Parámetros:
        
            inuProduct      Product id
            idtInitDate     Initial Date
            idtFinlDate     Final date
            inuExpConsType  Consumption type of exported energy
            itbExpEnergy    Detail of exported units by hour
            ircProdCons     Monthly energy usage
            onuUnitsExp2    Exported units above imported units
            onuValueExp2    Amount exported units
        *************************************************************************/
        PROCEDURE LiqExpAboveImp
        (
            inuProduct          in  gc_consmeho.comhsesu%type,
            idtInitDate         in  pericose.pecsfeci%type,
            idtFinlDate         in  pericose.pecsfeci%type,
            inuExpConsType      in  gc_consmeho.comhtcon%type,
            itbExpEnergy        in  PE_BOMarginalPrices.tytbPricesLiq,
            inuConsPeri         in  conssesu.cosscoca%type,
            inuPericose         in  pericose.pecscons%type,
            otbFecConsExc       out tytbFecConsEx        
        )
        IS
            tbMargPrices    PE_BOMarginalPrices.tytbPricesLiq;
            /* Total exported units */
            nuTotalUnits    cargos.cargunid%type := 0;
            /* Units per hour */
            nuHourlyUnits   gc_consmeho.comhunco%type;
            /* Exported units above imported units */
            nuUnitsExp2     cargos.cargunid%type := 0;
            /* Hash hourly records */
            sbHash          PE_BOMarginalPrices.styVarchar;
            /* Marginal cost */
            nuMargCost      fa_costmaho.comacost%type;
            /* It indicates that exported units have to be liquidated due to
               acumulated exported units are above of imported units */
            boLiqExp2       boolean := FALSE;
            /* Amount */
            nuValueExp2     cargos.cargvalo%type;
            
            sbFechExce      VARCHAR2(8);
            nuHoraExce      NUMBER;
            nucontador      NUMBER:=1;
        BEGIN
            ut_trace.trace('Init pkg_Epm_WebCoupon.GetExcedentesEnergia ['||inuProduct||']['||inuExpConsType||']',2);

            /* Get Prices */
            PE_BOMarginalPrices.GetMargPrices
            (
                inuProduct,
                idtInitDate,
                idtFinlDate,
                tbMargPrices
            );

            /* Initialize */
            nuTotalUnits := 0;
            nuUnitsExp2 := 0;
            nuValueExp2 := 0;
            
            sbHash := itbExpEnergy.first;

            WHILE (sbHash IS not null) LOOP

                nuTotalUnits := nuTotalUnits + itbExpEnergy(sbHash).comhunco;
                nuHourlyUnits := 0;
                nuMargCost := 0;

                /* Get units to liq */
                if(boLiqExp2) then
                    nuHourlyUnits := itbExpEnergy(sbHash).comhunco;
                elsif nuTotalUnits > nvl(inuConsPeri,0) THEN
                    nuHourlyUnits := nuTotalUnits - inuConsPeri;
                    boLiqExp2 := TRUE;
                else
                    /* No liquidate*/
                    sbHash := itbExpEnergy.next(sbHash);
                    continue;
                END IF;
                
                /* Get marginal cost */
                IF tbMargPrices.exists(sbHash) THEN
                    nuMargCost := tbMargPrices(sbHash).comacost;
                END IF;
                    
                /* Calculate liquidate units and amount */
                nuUnitsExp2 := nuUnitsExp2 + nuHourlyUnits;
                nuValueExp2 := nuValueExp2 + nuMargCost * nuHourlyUnits;
                ut_trace.trace('Hour: '||sbHash||' >> '||nuHourlyUnits||' X '||nuMargCost||' = '||nuMargCost * nuHourlyUnits,5);
                    
                sbFechExce:= SUBSTR(sbHash,1,8);
                nuHoraExce := replace(sbHash,sbFechExce);
                    
                -- calcula indice agrupamiento datos
                sbIdxVal :=  lpad(inuProduct,10,'0')||
                             lpad(sbFechExce,8,'0')||
                             lpad(nuHoraExce,2,'0')||
                             lpad(inuExpConsType,4,'0'||
                             lpad(inuPericose,15,'0'));
                                 
                -- almacena las horas excedentes liquidadas
                IF(tbValoresHora.exists(sbIdxVal)) THEN
                   
                    --Se asigna Numero de unidades Excedentes
                    tbValoresHora(sbIdxVal).nuunexce := tbValoresHora(sbIdxVal).nuunexce + nuHourlyUnits;
                        
                    --Se asigna Valor unidades
                    tbValoresHora (sbIdxVal).valounid:=  tbValoresHora (sbIdxVal).valounid + (nuMargCost * nuHourlyUnits);
                        
                    
                ELSE
                        
                    sbTipoCons:= pktbltipocons.fsbgetdescription(inuExpConsType);
                        
                    --Se asigna Tipo de consumo  
                    tbValoresHora (sbIdxVal).tcondesc:=sbTipoCons;
                        
                    --Se asigna la hora excedente
                    tbValoresHora(sbIdxVal).horaexce:=nuHoraExce;
                        
                    --Se asigna la fecha excedente
                    tbValoresHora(sbIdxVal).cossfere:=TO_DATE(sbFechExce,'YYYYMMDD');
                        
                    --Se asigna el perido de consumo  
                    tbValoresHora(sbIdxVal).cosspecs:= inuPericose;
                                    
                    --Se asigna fecha inicial perido de consumo  
                    tbValoresHora (sbIdxVal).pecsfeci:= idtInitDate;
                                    
                    --Se asigna fecha final perido de consumo  
                    tbValoresHora (sbIdxVal).pecsfecf:= idtFinlDate;
                        
                    --Se asigna el producto 
                    tbValoresHora(sbIdxVal).cosssesu:= inuProduct;
                                      
                    --Se asigna Numero de unidades Excedentes
                    tbValoresHora (sbIdxVal).nuunexce := nuHourlyUnits;
                                    
                    --Se asigna Precio Bolsa
                    tbValoresHora(sbIdxVal).precbols:= nuMargCost ;
                                    
                    --Se asigna Valor unidades
                    tbValoresHora (sbIdxVal).valounid:= nuMargCost * nuHourlyUnits;
                    
                END IF;
                    
                -- calcula indice agrupamiento datos
                sbIdxValTot  :=  lpad(9999999999,10,'0')||
                                 lpad('99999999',8,'0')||
                                 lpad('99',2,'0')||
                                 lpad('9999',4,'0'||
                                 lpad('999999999999999',15,'0'));
                                 
                -- almacena las horas excedentes liquidadas
                IF(tbValoresHora.exists(sbIdxValTot)) THEN
                   
                    --Se asigna Numero de unidades Excedentes
                    tbValoresHora(sbIdxValTot).nuunexce := tbValoresHora(sbIdxValTot).nuunexce + nuHourlyUnits;
                        
                    --Se asigna Valor unidades
                    tbValoresHora (sbIdxValTot).valounid:=  tbValoresHora (sbIdxValTot).valounid + (nuMargCost * nuHourlyUnits);
                    
                ELSE
                                      
                    --Se asigna Numero de unidades Excedentes
                    tbValoresHora (sbIdxValTot).nuunexce := nuHourlyUnits;
                                    
                    --Se asigna Valor unidades
                    tbValoresHora (sbIdxValTot).valounid:= nuMargCost * nuHourlyUnits;
                    
                END IF;
                
                sbHash := itbExpEnergy.next(sbHash);
                nucontador:=nucontador+1;
                
            END LOOP;
            
            onuUnitsExp2 := nuUnitsExp2;
            onuValueExp2 := nuValueExp2;

            ut_trace.trace('END pkg_Epm_WebCoupon.GetExcedentesEnergia',2);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ut_trace.trace('CONTROLLED_ERROR pkg_Epm_WebCoupon.GetExcedentesEnergia',2);
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('others pkg_Epm_WebCoupon.GetExcedentesEnergia',2);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END LiqExpAboveImp;
            
    BEGIN
        
        ut_trace.trace('Init pkg_Epm_WebCoupon.GetExcedentesEnergia ['||inuContrato||']['||inuPeriodFact||']['||nuTipoConsExp||']['||nuTipoConsImp||']',2);
            
        -- Inicializa variables
        tbCateTipoProd.DELETE;
        onuCodigoError  := 0;
        osbMensajeError := '-';        
            
        -- Inicializa cursor
        pIniCursorValorHora(orfValoresHora); 
                    
        -- validar nulos
        Pkg_Epm_Utilidades.ValidarNullNumber(inuContrato,'Contrato');
        Pkg_Epm_Utilidades.ValidarNullNumber(inuPeriodFact,'inuPeriodFact');
            
        -- Valida que el contrato exista
        pktblsuscripc.acckey(inuContrato);
            
        -- validar que el periodo exista
        pktblperifact.acckey(inuPeriodFact);
            
        -- Se inicializa el objeto
        tbGeneral := tbGeneral_Empty;
               
        pkg_EPM_Utilidades.ParseString (csbConcepTypeCons, '|', tbCateTipoProd);
            
        --Por cada contrato se obtienen los productos asociados
        FOR rcProdCont IN cuProdCont(inuContrato) LOOP
                
            FOR r_registros IN cuPeriConsxPeriFact(rcProdCont.sesunuse,inuPeriodFact) LOOP
                
                tbDetalle.DELETE;   
            
                nuIdx := tbCateTipoProd.FIRST;
                            
                nuPeriodoCons := r_registros.cosspecs;
                nuProduct     := rcProdCont.sesunuse;
                
                LOOP
                            
                    EXIT WHEN nuIdx IS NULL;           
                   
                    -- Inicializa variables
                    nuTotalUnits    := 0;
                    nuConsumoPeri   := 0;
                    dtInitDate      := null;
                    dtFinlDate      := null;
                    tbExpEnergy.delete;
                           
                    pkg_EPM_Utilidades.ParseString (tbCateTipoProd(nuIdx), ',', tbDetalle);
                          
                    nuTipoConsImp := tbDetalle(1);
                    nuTipoConsExp := tbDetalle(2);
                    nuConcepto    := tbDetalle(3); 
                          
                    /* Get Period Dates*/
                    GetPeriodDates
                    (
                        nuPeriodoCons,
                        nuConcepto,
                        dtInitDate,
                        dtFinlDate
                    );
                    
                    ut_trace.trace('nuProduct = '||nuProduct,2);
                    ut_trace.trace('nuPeriodoCons = '||nuPeriodoCons,2);
                    ut_trace.trace('nuTipoConsExp = '||nuTipoConsExp,2);
                    
                    /* Get hourly self-generation exported energy */
                    GetHourlyUsage
                    (
                        nuProduct,
                        dtInitDate,
                        dtFinlDate,
                        nuTipoConsExp,
                        nuTotalUnits, -- Out
                        tbExpEnergy -- Out
                    );
                    
                    ut_trace.trace('nuTotalUnits = '||nuTotalUnits,2);
                    
                    /* Validate if there is usage */
                    IF nuTotalUnits <= 0 THEN
                        ut_trace.trace('END pkg_Epm_WebCoupon.GetExcedentesEnergia [0]',2);
                        nuIdx := tbCateTipoProd.NEXT (nuIdx); 
                        CONTINUE;
                    END IF;
                   
                    ut_trace.trace('nuTipoConsImp = '||nuTipoConsImp,2);
                    
                    /* Get monthly usage */
                    GetMonthlyUsage
                    (   nuProduct,
                        nuPeriodoCons,
                        nuTipoConsImp,
                        nuConsumoPeri
                    );
                    
                    ut_trace.trace('nuConsumoPeri = '||nuConsumoPeri,2);
                    
                    /* This fx liquidate exported usage above imported usage.
                       If the exported is lower than imported, it doesn't need to be liquidated.
                    */
                    IF nuTotalUnits < nvl(nuConsumoPeri,0) THEN
                        ut_trace.trace('END pkg_Epm_WebCoupon.GetExcedentesEnergia [0]',2);
                        nuIdx := tbCateTipoProd.NEXT (nuIdx); 
                        CONTINUE;
                    END IF;
                            
                    /* Liquidate exported energy above monthly usage */
                    LiqExpAboveImp
                    (
                        nuProduct,
                        dtInitDate,
                        dtFinlDate,
                        nuTipoConsExp,
                        tbExpEnergy,
                        nuConsumoPeri,
                        nuPeriodoCons,
                        tbFecConsEx
                    );
                            
                    nuIdx := tbCateTipoProd.NEXT (nuIdx);   
                                                         
                END LOOP;
                       
            END LOOP;
               
        END LOOP;
            
        -- recorrer los valores hora
        nuIdx    := 0;
        sbIdxVal := tbValoresHora.first;
            
        loop
              
            exit when sbIdxVal IS NULL;
                
            nuIdx := nuIdx +1;
            tbGeneral(nuIdx).nuCampo01 := tbValoresHora(sbIdxVal).COSSSESU;
            tbGeneral(nuIdx).dtCampo01 := tbValoresHora(sbIdxVal).COSSFERE;
            tbGeneral(nuIdx).nuCampo02 := tbValoresHora(sbIdxVal).HORAEXCE;
            tbGeneral(nuIdx).sbCampo01 := tbValoresHora(sbIdxVal).TCONDESC;
            tbGeneral(nuIdx).nuCampo03 := tbValoresHora(sbIdxVal).NUUNEXCE;
            tbGeneral(nuIdx).nuCampo04 := tbValoresHora(sbIdxVal).PRECBOLS;
            tbGeneral(nuIdx).nuCampo05 := tbValoresHora(sbIdxVal).VALOUNID;
            tbGeneral(nuIdx).nuCampo06 := tbValoresHora(sbIdxVal).COSSPECS;
            tbGeneral(nuIdx).dtCampo02 := tbValoresHora(sbIdxVal).PECSFECI;
            tbGeneral(nuIdx).dtCampo03 := tbValoresHora(sbIdxVal).PECSFECF;
            tbGeneral.EXTEND(1,1);
              
            sbIdxVal := tbValoresHora.next(sbIdxVal);
              
        end loop;
            
        -- Elimina ultimo registro tabla
        tbGeneral.DELETE(tbGeneral.COUNT);
            
        -- Obtiene Cursor con Datos de Salida
        IF (tbGeneral.COUNT > 0 ) THEN
                
            -- Si esta abierto el cursor referenciado se cierra
            IF ( orfValoresHora%ISOPEN ) THEN
                CLOSE orfValoresHora;
            END IF;
                
            OPEN orfValoresHora FOR
            SELECT 
                nuCampo01 SERVICIO_SUSCRITO,
                dtCampo01 FECHA_DE_EXCEDENTE,
                nuCampo02 HORA_DE_EXCEDENTE,
                sbCampo01 TIPO_DE_CONSUMO,
                nuCampo03 NUMERO_UNIDADES_EXCEDENTE,
                nuCampo04 PRECIO_BOLSA,
                nuCampo05 VALOR_UNIDADES_EXCEDENTE,
                nuCampo06 PERIODO_DE_CONSUMO,
                dtCampo02 FECHA_INI_PERICONSUMO,
                dtCampo03 FECHA_FIN_PERICONSUMO
            FROM TABLE(CAST(tbGeneral AS epm_tyGeneral));

        END IF;
            
        -- Se inicializa el objeto
        tbGeneral := tbGeneral_Empty;
       
        ut_trace.trace('END pkg_Epm_WebCoupon.GetExcedentesEnergia ['||onuUnitsExp2||']['||onuValueExp2||']',2);
        
     EXCEPTION
        WHEN Epm_Errors.EX_CTRLERROR THEN
            Pkg_Epm_Utilidades.Trace_SetMsg(csbSP_NAME||csbMT_NAME, cnuNVLTRC, csbPOP_ERC); 
            pIniCursorValorHora(orfValoresHora);   
            Epm_Errors.Geterror(onuCodigoError, osbMensajeError);
        WHEN OTHERS THEN
            Pkg_Epm_Utilidades.Trace_SetMsg(csbSP_NAME||csbMT_NAME, cnuNVLTRC, csbPOP_ERR); 
            pIniCursorValorHora(orfValoresHora);
            Epm_Errors.SetError;    
            Epm_Errors.GetError (onuCodigoError, osbMensajeError);
    END GetExcedentesEnergia;
    
END pkg_Epm_WebCoupon;
/
