# Trabalho Final de SSC0714 - Robôs móveis autônomos

## Rodando o Trabalho:

Em um terminal, rode os seguintes comandos:
```
docker-compose build 
xhost +local:docker
docker-compose up
```
Eles devem ser rodados na primeira vez que se for rodar o trabalho. Se o container for utilizado posteriormente, basta usar o comando
```
xhost +local:docker
ros2-gazebo-docker_ros2_humble_gazebo
```
Cuidado com containers pré-existentes. Uma vez que os comandos do compose foram dados uma vez e o container criado não foi apagado, vai dar erro.\
Em seguida, abra outro terminal e rode os seguintes comandos:
```
docker exec -it ros2-gazebo-docker_ros2_humble_gazebo bash
#todos os comandos depois deste serão rodados dentro do container
cd /ros2_humble_ws
export MAKEFLAGS="-j 1"
colcon build --parallel-workers=1 --executor sequential
#a compilação demora consideravelmente. O ros_gz só precisa ser compilado uma vez
source install/setup.bash
ros2 run final waypoints_and_dodge
```
Abra outro terminal e rode
```
docker exec -it ros2-gazebo-docker_ros2_humble_gazebo bash
#todos os comandos depois deste serão rodados dentro do container
cd /ros2_humble_ws/larasim
bash run.bash
```
O simulador gazebo irá abrir, e uma bridge entre o gazebo e o ROS2 será estabelecida. Depois disso, basta dar play e assistir a simulação

# Adicionais:
O objetivo deste trabalho era fornecer múltiplos pacotes com exemplos de código em ROS para fins didáticos, e material explicando o seu funcionamento. O material não foi escrito, mas vários dos pacotes planejados foram. Eles são:
## Primitive Teleop
Teleoperação da pioneer simulada em gazebo através das teclas wasd. Tal como o pacote oficial TeleopTwistKeyboard, usa espera ocupada.
## Sensores
Permite a visualização dos dados de odometria e lidar da pioneer simulada em gazebo. Também explica como extrair dados do lidar e calcular os índices correspondentes a um dado ângulo
## State Machine:
Apenas um dos 3 exemplos planejados foi feito: a criação de uma máquina de estados simples através do uso de variáveis específicas.
## Waypoints:
Código para um marcador de waypoints simples teleoperado e um seguidor de waypoints simples. O seguidor de waypoints usa os dados do mesmo .csv do trabalho final, que é ```/ros2_humble_ws/src/paths/chosen_path.csv```. Waypoints marcados com o nó mark_waypoints são salvos em ```/ros2_humble_ws/src/paths/latest.csv```.

# Final:
O trabalho propriamente dito da disciplina: uma máquina de estados que lê um arquivo de waypoints e os segue em ordem até encontrar um obstáculo, a partir deste momento o robô se comporta como um seguidor de parede até a parede em questão acabar. A partir desse ponto, o robô volta a seguir para o waypoint em linha reta.
### Pontos fortes e adicionais:
1. Uso de todos os dados do lidar pertinentes à área de interesse, ao invés de amostragem de leituras específicas
2. Inicialização e calibragem do nó durante o primeiro ciclo de execução faz do programa mais eficiente em termos de uso de recursos
3. Implementação parcial de desaceleração amortecida para evitar solavancos e derrapagens
### Pontos fracos e problemas que eu não consegui resolver em tempo hábil:
1. Completa ausência de árvore de transformações. Ocasional colisões eventuais em curvas fechadas ou com paredes finas
2. Limitações da máquina de estados "gambiarra". Complexidade limitada para cada estado (e virtualmente impossibilidade de fazer "sub-máquinas de estado" sem tornar o código completamente ilegível) resulta em dificuldade de execução paralela de tarefas.
3. Problemas com o simulador. A odometria é extremamente instável e apresenta um erro de 10%, o que a faz virtualmente inútil para caminhos mais extensos. Eu comecei a implementar um sistema de beacons para calibrar a odometria regularmente, mas se mostrou muito trabalhoso, e se possível eu teria utilizado GPS desde o começo, como recomendado. Vale ressaltar que esse erro é exclusivo da simulação, e pioneers reais apresentam erro de odometria consideravelmente inferior.
4. Ajuste de ângulo sempre escolhe a rota que não passa por +-2pi, resultando em situações na qual o robô dá uma volta consideravelmente maior do que precisava para se alinhar com seu destino
5. Não foi testado no Windows.