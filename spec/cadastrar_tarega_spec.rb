describe 'cadastrar' do
    def login(field_email, field_password)
        @body = {
            session: {
                email: field_email,
                password: field_password
            }
        }.to_json

        @login = Login.post('/sessions', body: @body)
        puts @login
    end

    context 'tarefas' do
        before { login('pri.ribeirofranca@gmail.com', '123456')}

        it 'com sucesso' do
            @header = {
                'Content-Type': 'application/json',
                Accept: 'application/vnd.tasksmanagers.v2',
                Authorization: @login.parsed_response['data']['attributes']['auth-token']
            }

            @body = {
                task: {
                    title: 'criei Tarefa 27',
                    description: 'criei da tarefa',
                    deadline: '2020-08-21 15:00:00',
                    done: true
                }
            }.to_json

            @tarefas_cadastrar = Cadastrar.post('/tasks', body: @body, headers: @header)
            puts @tarefas_cadastrar.body
            expect(@tarefas_cadastrar.parsed_response['data']['attributes']['title']). to eq 'criei Tarefa 27'
        end
    end
end