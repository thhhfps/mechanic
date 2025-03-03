// Função para fechar o menu
function closeMenu() {
    fetch('https://your_resource_name/closeMenu', {
        method: 'POST',
        body: JSON.stringify({})
    }).then(() => {
        document.getElementById('menu').style.display = 'none';
    });
}

// Função para aplicar upgrades
function applyUpgrade(upgrade, level) {
    fetch('https://your_resource_name/applyUpgrade', {
        method: 'POST',
        body: JSON.stringify({ upgrade: upgrade, level: level })
    }).then(() => {
        alert(upgrade + ' aplicado com sucesso!');
    });
}

// Recebe a mensagem para abrir o menu
window.addEventListener('message', function(event) {
    if (event.data.type === 'openMenu') {
        document.getElementById('menu').style.display = 'block';
    }
});