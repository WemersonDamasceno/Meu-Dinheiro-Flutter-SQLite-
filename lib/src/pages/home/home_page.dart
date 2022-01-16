import 'package:finances/src/models/movimentacoes.dart';
import 'package:finances/src/pages/home/widgets/movimentacao_widget.dart';
import 'package:finances/src/stores/movimentacoes/movimentacoes_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'widgets/input_widget.dart';


//Instancia dos stores    
final storeMov = MovimentacoesStore();

TextEditingController controllerTitulo = TextEditingController();
TextEditingController controllerValor = TextEditingController();
var controllerIcon = 1;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    controllerIcon = 1;
    controllerTitulo.dispose();
    controllerValor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: _size.height * .25,
                width: _size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFF08148),
                      Color(0xFFF96C25),
                      Color(0xFFC70C0C),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _size.width * 0.1,
                      vertical: _size.height * .08),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Olá, Wemerson",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Seja bem vindo!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _size.height * .18,
                left: _size.width * .05,
                child: SizedBox(
                  height: _size.height * .13,
                  width: _size.width * .9,
                  child: Card(
                    color: const Color(0xFFFF4328),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Saldo disponível",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "R\$ 0,00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Colors.white,
                            ),
                            Icon(Icons.visibility_off, color: Colors.white),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: _size.height * .32,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                  child: const Text(
                    "Saldo financeiro",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 80,
                    width: _size.width * .4,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Entradas"),
                          Text(
                            "R\$ 0,00",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: _size.width * .4,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Saidas"),
                          Text("R\$ 0,00",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _size.width * 0.05,
                          right: _size.width * 0.05,
                          top: 10),
                      child: const Text(
                        "Movimentações",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Observer(builder: (_) =>
                    SizedBox(
                      height: _size.height * .44,
                      child: storeMov.listMovimentacao.length >0
                          ? Observer(builder: (_)=>
                          ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: storeMov.listMovimentacao.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ItemMovimentacaoWidget(
                                    titulo: storeMov.listMovimentacao[index].titulo!,
                                    data: storeMov.listMovimentacao[index].data!,
                                    valor: storeMov.listMovimentacao[index].valor!,
                                    icon: storeMov.listMovimentacao[index].icon!,
                                    despesa: storeMov.listMovimentacao[index].isDespesa!,
                                    colorIcon:
                                        storeMov.listMovimentacao[index].colorIcon!);
                              })
                          )
                          : Column(
                              children: [
                                SizedBox(
                                  width: _size.width * .6,
                                  child: LottieBuilder.asset(
                                      "assets/lottie/pig_animation.json"),
                                ),
                                const Text("Você ainda não possui movimentações"),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _configurandoModalBottomSheet(context);
        },
        backgroundColor: const Color(0xFFFF4328),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              ListTile(
                  leading: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  title: const Text('Entradas'),
                  onTap: () {
                    Navigator.pop(context);
                    _exibirDialogEntradas(context);
                  }),
              ListTile(
                  leading: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  title: const Text('Despesas'),
                  onTap: () {
                    Navigator.pop(context);
                    _exibirDialogSaidas(context);
                  }),
            ],
          );
        });
  }

  void _exibirDialogEntradas(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DialogAddEntradas();
        });
  }

   void _exibirDialogSaidas(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DialogAddSaidas();
        });
  }



}

class DialogAddSaidas extends StatefulWidget {
  const DialogAddSaidas({ Key? key }) : super(key: key);

  @override
  _DialogAddSaidasState createState() => _DialogAddSaidasState();
}

class _DialogAddSaidasState extends State<DialogAddSaidas> {

  @override
  void dispose() {
    controllerIcon = 1;
    controllerTitulo.dispose();
    controllerValor.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controllerIcon = 1;
    controllerValor = TextEditingController();
    controllerTitulo = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 8),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Adicionar uma despesa',
                      style: TextStyle(fontSize: 17),
                    )),
              ),
              InputWidget(
                labelText: "Titulo",
                icon: Icons.message,
                txtController: controllerTitulo,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                labelText: "Valor",
                icon: Icons.monetization_on_rounded,
                type: TextInputType.number,
                txtController: controllerValor,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Escolha um icone',
                      style: TextStyle(fontSize: 17),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        controllerIcon = 1;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color:
                            controllerIcon == 1
                                ? Colors.red
                                : Colors.transparent,
                        child: const Card(
                            elevation: 1,
                            child: Icon(Icons.water_damage_outlined)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        controllerIcon = 2;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color:
                            controllerIcon == 2
                                ? Colors.red
                                : Colors.transparent,
                        child: const Card(
                            elevation: 1,
                            child: Icon(Icons.money_off)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              SizedBox(
                width: size.width,
                height: size.height * .05,
                child: ElevatedButton(
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    
                    String dia = "${DateTime.now().day}";
                    String mes = "${DateTime.now().month}";
                    if(DateTime.now().day < 10){
                      dia = "0${DateTime.now().day}";
                    }
                    if(DateTime.now().month < 10){
                      mes = "0${DateTime.now().month}";
                    }
                   
                    ItemMovimentacao item = ItemMovimentacao(
                      colorIcon: Colors.red,
                      isDespesa: true,
                      data: "$dia/$mes/${DateTime.now().year}",
                      id: 0,
                      titulo: controllerTitulo.text,
                      valor: controllerValor.text,
                      icon:  controllerIcon == 1 ? Icons.water_damage_outlined : Icons.money_off,
                      );
                    
                    storeMov.addItemMovimentacao(item);
                    Navigator.pop(context);                    
                  } 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogAddEntradas extends StatefulWidget {
  const DialogAddEntradas({ Key? key }) : super(key: key);

  @override
  _DialogAddEntradasState createState() => _DialogAddEntradasState();
}

class _DialogAddEntradasState extends State<DialogAddEntradas> {  
  
  @override
  void dispose() {
    controllerIcon = 1;
    controllerTitulo.dispose();
    controllerValor.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controllerIcon = 1;
    controllerValor = TextEditingController();
    controllerTitulo = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 8),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Adicionar uma renda',
                      style: TextStyle(fontSize: 17),
                    )),
              ),
              InputWidget(
                labelText: "Titulo",
                icon: Icons.message,
                txtController: controllerTitulo,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                labelText: "Valor",
                icon: Icons.monetization_on_rounded,
                type: TextInputType.number,
                txtController: controllerValor,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Escolha um icone',
                      style: TextStyle(fontSize: 17),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        controllerIcon = 1;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color:
                            controllerIcon == 1
                                ? Colors.red
                                : Colors.transparent,
                        child: const Card(
                            elevation: 1,
                            child: Icon(Icons.account_balance_wallet_rounded)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        controllerIcon = 2;
                      }),
                      child: Container(
                        height: 70,
                        width: 90,
                        color:
                            controllerIcon == 2
                                ? Colors.red
                                : Colors.transparent,
                        child: const Card(
                            elevation: 1,
                            child: Icon(Icons.monetization_on_outlined)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              SizedBox(
                width: size.width,
                height: size.height * .05,
                child: ElevatedButton(
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    
                    String dia = "${DateTime.now().day}";
                    String mes = "${DateTime.now().month}";
                    if(DateTime.now().day < 10){
                      dia = "0${DateTime.now().day}";
                    }
                    if(DateTime.now().month < 10){
                      mes = "0${DateTime.now().month}";
                    }
                   
                    ItemMovimentacao item = ItemMovimentacao(
                      colorIcon: Colors.green,
                      isDespesa: false,
                      data: "$dia/$mes/${DateTime.now().year}",
                      id: 0,
                      titulo: controllerTitulo.text,
                      valor: controllerValor.text,
                      icon:  controllerIcon == 1 ? Icons.account_balance_wallet_rounded : Icons.monetization_on_outlined,
                      );
                    
                    storeMov.addItemMovimentacao(item);
                    Navigator.pop(context);                    
                  } 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}