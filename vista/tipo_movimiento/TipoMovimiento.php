<?php
/**
 *@package pXP
 *@file TipoMovimiento.php
 *@author  Gonzalo Sarmiento Sejas
 *@date 23-12-2016
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.TipoMovimiento=Ext.extend(Phx.arbGridInterfaz,{

				constructor:function(config){
					this.maestro=config.maestro;
					//this.initButtons=[this.cmbGestion];
					//llama al constructor de la clase padre
					Phx.vista.TipoMovimiento.superclass.constructor.call(this,config);
					this.loaderTree.baseParams={};
					this.init();
					this.iniciarEventos();

					//this.cmbGestion.on('select',this.capturaFiltros,this);
					//this.addButton('bAux',{text:'Auxiliares',iconCls: 'blist',disabled:true,handler:this.onButonAux,tooltip: '<b>Auxiliares de la cuenta</b><br/>Se habilita si esta cuenta tiene permitido el registro de auxiliares '});
					/*this.addButton('btnImprimir',
							{
								text: 'Imprimir',
								iconCls: 'bprint',
								disabled: true,
								handler: this.imprimirCbte,
								tooltip: '<b>Imprimir Plan de Cuentas</b><br/>Imprime el Plan de Cuentas en el formato oficial.'
							}
					);*/
					//Crea el botón para llamar a la replicación
					/*this.addButton('btnRepRelCon',
							{
								text: 'Duplicar Plan de Cuentas',
								iconCls: 'bchecklist',
								disabled: false,
								handler: this.duplicarCuentas,
								tooltip: '<b>Clonar  las cuentas para las gestión siguiente </b><br/>Clonar las cuentas, para la gestión siguiente guardando las relacion entre las mismas'
							}
					);*/



				},



				/*duplicarCuentas: function(){
					if(this.cmbGestion.getValue()){
						Phx.CP.loadingShow();
						Ext.Ajax.request({
							url: '../../sis_contabilidad/control/Cuenta/clonarCuentasGestion',
							params:{
								id_gestion: this.cmbGestion.getValue()
							},
							success: this.successRep,
							failure: this.conexionFailure,
							timeout: this.timeout,
							scope: this
						});
					}
					else{
						//alert('primero debe selecionar la gestion origen');
					}

				},*/

				/*successRep:function(resp){
					Phx.CP.loadingHide();
					var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
					if(!reg.ROOT.error){
						this.reload();
						alert(reg.ROOT.datos.observaciones)
					}else{
						alert('Ocurrió un error durante el proceso')
					}
				},*/

				/*capturaFiltros:function(combo, record, index){

					this.loaderTree.baseParams={id_gestion:this.cmbGestion.getValue()};
					this.root.reload();
					if(this.cmbGestion.getValue()){
						this.getBoton('btnImprimir').setDisabled(false);
					}
					else{
						this.getBoton('btnImprimir').setDisabled(true);
					}
				},*/
				/*imprimirCbte: function(){
					Phx.CP.loadingShow();
					Ext.Ajax.request({
						//url : '../../sis_contabilidad/control/IntComprobante/reporteComprobante',
						url : '../../sis_contabilidad/control/Cuenta/reportePlanCuentas',
						params : {
							'id_gestion' : this.cmbGestion.getValue()
						},
						success : this.successExport,
						failure : this.conexionFailure,
						timeout : this.timeout,
						scope : this
					});
				},*/

				Atributos:[
					{
						//configuracion del componente
						config:{
							labelSeparator:'',
							inputType:'hidden',
							name: 'id_tipo_movimiento'
						},
						type:'Field',
						form:true
					},
					{
						config:{
							name: 'nombre_movimiento',
							fieldLabel: 'Nombre Movimiento',
							allowBlank: false,
							anchor: '80%',
							gwidth: 100,
							maxLength:50
						},
						type:'TextField',
						filters:{pfiltro:'tipmov.nombre_movimiento',type:'string'},
						id_grupo:1,
						grid:true,
						form:true
					},
					{
						config:{
							name: 'orden',
							fieldLabel: 'Orden',
							allowBlank: false,
							anchor: '80%',
							gwidth: 100,
							maxLength:1310722
						},
						type:'NumberField',
						filters:{pfiltro:'tipmov.orden',type:'numeric'},
						id_grupo:1,
						grid:true,
						form:true
					},
					{
						config:{
							name: 'nivel',
							fieldLabel: 'Nivel',
							allowBlank: false,
							anchor: '80%',
							gwidth: 100,
							maxLength:4
						},
						type:'NumberField',
						filters:{pfiltro:'tipmov.nivel',type:'numeric'},
						id_grupo:1,
						grid:true,
						form:true
					},
					{
						config:{
							name: 'tipo',
							fieldLabel: 'Tipo',
							allowBlank: false,
							anchor: '80%',
							gwidth: 100,
							maxLength:50
						},
						type:'TextField',
						filters:{pfiltro:'tipmov.tipo',type:'string'},
						id_grupo:1,
						grid:true,
						form:true
					},
					{
						config:{
							name: 'fk_tipo_movimiento',
							inputType:'hidden'
						},
						type:'Field',
						form:true,
						grid:false
					},
					{
						config:{
							name: 'estado_reg',
							fieldLabel: 'Estado Reg.',
							allowBlank: true,
							anchor: '80%',
							gwidth: 100,
							maxLength:10
						},
						type:'TextField',
						filters:{pfiltro:'tipmov.estado_reg',type:'string'},
						id_grupo:1,
						grid:true,
						form:false
					},
					{
						config:{
							name: 'id_usuario_ai',
							fieldLabel: '',
							allowBlank: true,
							anchor: '80%',
							gwidth: 100,
							maxLength:4
						},
						type:'Field',
						filters:{pfiltro:'tipmov.id_usuario_ai',type:'numeric'},
						id_grupo:1,
						grid:false,
						form:false
					},
					{
						config:{
							name: 'fecha_reg',
							fieldLabel: 'Fecha creación',
							allowBlank: true,
							anchor: '80%',
							gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
						},
						type:'DateField',
						filters:{pfiltro:'tipmov.fecha_reg',type:'date'},
						id_grupo:1,
						grid:true,
						form:false
					},
					{
						config:{
							name: 'usuario_ai',
							fieldLabel: 'Funcionaro AI',
							allowBlank: true,
							anchor: '80%',
							gwidth: 100,
							maxLength:300
						},
						type:'TextField',
						filters:{pfiltro:'tipmov.usuario_ai',type:'string'},
						id_grupo:1,
						grid:true,
						form:false
					},
					{
						config:{
							name: 'usr_reg',
							fieldLabel: 'Creado por',
							allowBlank: true,
							anchor: '80%',
							gwidth: 100,
							maxLength:4
						},
						type:'Field',
						filters:{pfiltro:'usu1.cuenta',type:'string'},
						id_grupo:1,
						grid:true,
						form:false
					},
					{
						config:{
							name: 'fecha_mod',
							fieldLabel: 'Fecha Modif.',
							allowBlank: true,
							anchor: '80%',
							gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
						},
						type:'DateField',
						filters:{pfiltro:'tipmov.fecha_mod',type:'date'},
						id_grupo:1,
						grid:true,
						form:false
					},
					{
						config:{
							name: 'usr_mod',
							fieldLabel: 'Modificado por',
							allowBlank: true,
							anchor: '80%',
							gwidth: 100,
							maxLength:4
						},
						type:'Field',
						filters:{pfiltro:'usu2.cuenta',type:'string'},
						id_grupo:1,
						grid:true,
						form:false
					}
				],

				title:'Tipo Movimiento',
				ActSave:'../../sis_bancos/control/TipoMovimiento/insertarTipoMovimiento',
				ActDel:'../../sis_bancos/control/TipoMovimiento/eliminarTipoMovimiento',
				ActList:'../../sis_bancos/control/TipoMovimiento/listarTipoMovimientoArb',
				id_store:'id_tipo_movimiento',

				textRoot:'Tipos de Movimiento',
				id_nodo:'id_tipo_movimiento',
				id_nodo_p:'fk_tipo_movimiento',

				fields: [
					{name:'id_tipo_movimiento', type: 'numeric'},
					{name:'nombre_movimiento', type: 'string'},
					{name:'orden', type: 'numeric'},
					{name:'nivel', type: 'numeric'},
					{name:'fk_tipo_movimiento', type: 'numeric'},
					{name:'estado_reg', type: 'string'},
					{name:'id_usuario_ai', type: 'numeric'},
					{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
					{name:'usuario_ai', type: 'string'},
					{name:'id_usuario_reg', type: 'numeric'},
					{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
					{name:'id_usuario_mod', type: 'numeric'},
					{name:'usr_reg', type: 'string'},
					{name:'usr_mod', type: 'string'}
				],

				/*cmbGestion: new Ext.form.ComboBox({
					fieldLabel: 'Gestion',
					allowBlank: true,
					emptyText:'Gestion...',
					store:new Ext.data.JsonStore(
							{
								url: '../../sis_parametros/control/Gestion/listarGestion',
								id: 'id_gestion',
								root: 'datos',
								sortInfo:{
									field: 'gestion',
									direction: 'DESC'
								},
								totalProperty: 'total',
								fields: ['id_gestion','gestion'],
								// turn on remote sorting
								remoteSort: true,
								baseParams:{par_filtro:'gestion'}
							}),
					valueField: 'id_gestion',
					triggerAction: 'all',
					displayField: 'gestion',
					hiddenName: 'id_gestion',
					mode:'remote',
					pageSize:50,
					queryDelay:500,
					listWidth:'280',
					width:80
				}),*/

				sortInfo:{
					field: 'id_tipo_movimiento',
					direction: 'ASC'
				},
				bdel:true,
				bsave:false,
				rootVisible:true,
				expanded:false,

				getTipoMovimientoPadre: function(n) {
					var direc
					var padre = n.parentNode;
					if (padre) {
						if (padre.attributes.id != 'id') {
							return this.getTipoMovimientoPadre(padre);
						} else {
							return n.attributes.tipo;
						}
					} else {
						return undefined;
					}
				},

				preparaMenu:function(n){
					if(n.attributes.tipo_nodo == 'hijo' || n.attributes.tipo_nodo == 'raiz' || n.attributes.id == 'id'){
						this.tbar.items.get('b-new-'+this.idContenedor).enable()
					}
					else {
						this.tbar.items.get('b-new-'+this.idContenedor).disable()
					}
					/*
					if(n.attributes.sw_auxiliar == 'si'){
						this.getBoton('bAux').enable();
					}
					else{
						this.getBoton('bAux').disable();
					}*/


					// llamada funcion clase padre
					Phx.vista.TipoMovimiento.superclass.preparaMenu.call(this,n);
				},

				liberaMenu:function(n){
					//this.getBoton('bAux').disable();

					// llamada funcion clase padre
					Phx.vista.TipoMovimiento.superclass.liberaMenu.call(this,n);

				},

				/*
				loadValoresIniciales:function()
				{
					Phx.vista.TipoMovimiento.superclass.loadValoresIniciales.call(this);
					this.getComponente('id_gestion').setValue(this.cmbGestion.getValue());

				},*/

				onButtonEdit:function(n){
					//this.ocultarComponente(this.cmpTipoCuenta);
					//this.ocultarComponente(this.cmpTipoCuentaPat);
					//this.ocultarComponente(this.cmpDigito);
					//this.cmpNroCuenta.disable();
					Phx.vista.TipoMovimiento.superclass.onButtonEdit.call(this);

					//var nodo = this.sm.getSelectedNode(this.cmpTipoCuenta);
/*
					if(this.cmpTipoCuenta.getValue() =='patrimonio'){
						this.mostrarComponente(this.cmpTipoCuentaPat);
					} else{
						this.ocultarComponente(this.cmpTipoCuentaPat);
					}
*/


				},
				/*
				onButtonNew:function(n){

					if(this.cmbGestion.getValue()){

						this.ocultarComponente(this.cmpTipoCuentaPat);
						this.mostrarComponente(this.cmpTipoCuenta);

						this.cmpNroCuenta.disable();

						Phx.vista.Cuenta.superclass.onButtonNew.call(this);
						var nodo = this.sm.getSelectedNode(this.cmpTipoCuenta);


						if(nodo && nodo.attributes.id!='id'){
							console.log('nodos .... ',nodo, n)
							//si no es el nodo raiz
							this.cmpTipoCuenta.disable();
							this.cmpTipoCuenta.setValue(this.getTipoCuentaPadre(nodo));
							this.Cmp.valor_incremento.setValue(nodo.attributes.valor_incremento);
							this.Cmp.eeff.setValue(nodo.attributes.eeff);



							if(this.cmpTipoCuenta.getValue() =='patrimonio'){
								this.mostrarComponente(this.cmpTipoCuentaPat);
							} else{
								this.ocultarComponente(this.cmpTipoCuentaPat);
							}

							this.mostrarComponente(this.cmpDigito);
							this.cmpNroCuenta.setValue(nodo.attributes.nro_cuenta);
						}
						else{
							//si es el nodo raiz
							this.ocultarComponente(this.cmpDigito);
							this.cmpTipoCuenta.enable();
						}
					}
					else
					{
						alert("seleccione una gestion primero");

					}
				},*/
				/*
				onButonAux:function(){
					var nodo = this.sm.getSelectedNode();
					Phx.CP.loadWindows('../../../sis_contabilidad/vista/cuenta_auxiliar/CuentaAuxiliar.php',
							'Interfaces',
							{
								width:900,
								height:400
							},nodo.attributes,this.idContenedor,'CuentaAuxiliar')
				},*/
				iniciarEventos:function(){


					this.cmpNombreMovimiento = this.getComponente('nombre_movimiento');
					this.cmpOrden=this.getComponente('orden');
					this.cmpNivel =this.getComponente('nivel');
					//this.cmpTipoMovimiento=this.getComponente('fk_tipo_movimiento');

					/*this.cmpTipoMovimiento.on('beforeselect',function(combo,record,index){

						//this.cmpNroCuenta.setValue(record.data.nro_base);
						/*if(record.data.tipo_cuenta =='patrimonio'){
							this.mostrarComponente(this.cmpTipoCuentaPat);
						} else{
							this.ocultarComponente(this.cmpTipoCuentaPat);
						}*/

						//this.cmpNombreCuenta.setValue( Ext.util.Format.capitalize(record.data.tipo_cuenta));
						//this.cmpSwTransaccional.setValue('titular');

					//},this);*/

					/*
					this.cmpDigito.on('change',function(field,n,o){

						var nodo = this.sm.getSelectedNode(this.cmpTipoCuenta);
						if(nodo){
							this.cmpNroCuenta.setValue( nodo.attributes.nro_cuenta+'.'+n);
						}

					},this);
					*/
				}
			}
	)
</script>
