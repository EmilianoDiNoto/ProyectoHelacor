// LOGIN Y CONTRASEÑAS
document
  .getElementById("loginForm")
  .addEventListener("submit", function (event) {
    event.preventDefault();

    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const errorMessage = document.getElementById("errorMessage");

    const users = {
      valenrr01: "qwerty1",
      emidd02: "qwerty2",
      emmagg03: "qwerty3",
      pablocc04: "qwerty4",
      sofiarr05: "qwerty5",
      dianazz06: "qwerty6",
    };

    if (users[username] && users[username] === password) {
      window.location.href = "index.html";
    } else {
      errorMessage.textContent = "Usuario o contraseña incorrectos.";
    }
  });

// TRAZABILIDAD

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("addForm");
  form.addEventListener("submit", addRecord);
});

function addRecord(event) {
  event.preventDefault();

  const material = document.getElementById("material").value;
  const entryDate = document.getElementById("entryDate").value;
  const exitDate = document.getElementById("exitDate").value;
  const history = document.getElementById("history").value;

  const table = document
    .getElementById("traceabilityTable")
    .getElementsByTagName("tbody")[0];
  const newRow = table.insertRow();

  newRow.insertCell(0).innerText = table.rows.length;
  newRow.insertCell(1).innerText = material;
  newRow.insertCell(2).innerText = entryDate;
  newRow.insertCell(3).innerText = exitDate;
  newRow.insertCell(4).innerText = history;

  form.reset();
}

function filterTable() {
  const input = document.getElementById("searchInput");
  const filter = input.value.toLowerCase();
  const table = document.getElementById("traceabilityTable");
  const tr = table.getElementsByTagName("tr");

  for (let i = 1; i < tr.length; i++) {
    tr[i].style.display = "none";
    const tdArray = tr[i].getElementsByTagName("td");
    for (let j = 0; j < tdArray.length; j++) {
      if (tdArray[j]) {
        if (tdArray[j].innerText.toLowerCase().indexOf(filter) > -1) {
          tr[i].style.display = "";
          break;
        }
      }
    }
  }
}

// INVENTARIO ACTUAL

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("addForm");
  form.addEventListener("submit", addRecord);
});

function addRecord(event) {
  event.preventDefault();

  const itemName = document.getElementById("itemName").value;
  const quantity = document.getElementById("quantity").value;
  const status = document.getElementById("status").value;

  const table = document
    .getElementById("inventoryTable")
    .getElementsByTagName("tbody")[0];
  const newRow = table.insertRow();

  newRow.insertCell(0).innerText = table.rows.length;
  newRow.insertCell(1).innerText = itemName;
  newRow.insertCell(2).innerText = quantity;
  newRow.insertCell(3).innerText = status;

  form.reset();
}

function filterTable() {
  const input = document.getElementById("searchInput");
  const filter = input.value.toLowerCase();
  const table = document.getElementById("inventoryTable");
  const tr = table.getElementsByTagName("tr");

  for (let i = 1; i < tr.length; i++) {
    tr[i].style.display = "none";
    const tdArray = tr[i].getElementsByTagName("td");
    for (let j = 0; j < tdArray.length; j++) {
      if (tdArray[j]) {
        if (tdArray[j].innerText.toLowerCase().indexOf(filter) > -1) {
          tr[i].style.display = "";
          break;
        }
      }
    }
  }
}

function generateImage() {
  html2canvas(document.querySelector("main")).then((canvas) => {
    let link = document.createElement("a");
    link.download = "inventario.png";
    link.href = canvas.toDataURL("image/png");
    link.click();
  });
}

// AJUSTE DE INVENTARIO

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("adjustForm");
  form.addEventListener("submit", registerAdjustment);
});

function registerAdjustment(event) {
  event.preventDefault();

  const product = document.getElementById("product").value;
  const quantity = parseInt(document.getElementById("quantity").value);
  const isPositive = event.submitter.id === "positiveAdjust";

  const table = document
    .getElementById("inventoryTable")
    .getElementsByTagName("tbody")[0];
  let existingRow = null;

  for (let i = 0; i < table.rows.length; i++) {
    if (table.rows[i].cells[1].innerText === product) {
      existingRow = table.rows[i];
      break;
    }
  }

  if (existingRow) {
    const currentQuantity = parseInt(existingRow.cells[2].innerText);
    existingRow.cells[2].innerText = isPositive
      ? currentQuantity + quantity
      : currentQuantity - quantity;
  } else {
    const newRow = table.insertRow();
    newRow.insertCell(0).innerText = table.rows.length;
    newRow.insertCell(1).innerText = product;
    newRow.insertCell(2).innerText = isPositive ? quantity : -quantity;
  }

  form.reset();
}

// Registrar Ajuste de Inventario

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("adjustForm");
  form.addEventListener("submit", registerAdjustment);
});

function registerAdjustment(event) {
  event.preventDefault();

  const product = document.getElementById("product").value;
  const quantity = parseInt(document.getElementById("quantity").value);
  const isPositive = event.submitter.id === "positiveAdjust";

  const table = document
    .getElementById("inventoryTable")
    .getElementsByTagName("tbody")[0];
  let existingRow = null;

  for (let i = 0; i < table.rows.length; i++) {
    if (table.rows[i].cells[1].innerText === product) {
      existingRow = table.rows[i];
      break;
    }
  }

  if (existingRow) {
    const currentQuantity = parseInt(existingRow.cells[2].innerText);
    existingRow.cells[2].innerText = isPositive
      ? currentQuantity + quantity
      : currentQuantity - quantity;
  } else {
    const newRow = table.insertRow();
    newRow.insertCell(0).innerText = table.rows.length;
    newRow.insertCell(1).innerText = product;
    newRow.insertCell(2).innerText = isPositive ? quantity : -quantity;
  }

  form.reset();
}

//Registro de Movimientos de Materiales

document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("movementForm");
  const recordTableBody = document.getElementById("recordTableBody");

  form.addEventListener("submit", function (event) {
    event.preventDefault();

    const user = document.getElementById("user").value;
    const origin = document.getElementById("origin").value;
    const destination = document.getElementById("destination").value;
    const details = document.getElementById("details").value;
    const date = new Date().toLocaleString();

    const newRow = document.createElement("tr");
    newRow.innerHTML = `
          <td>${user}</td>
          <td>${origin}</td>
          <td>${destination}</td>
          <td>${details}</td>
          <td>${date}</td>
      `;

    recordTableBody.appendChild(newRow);

    form.reset();
  });
});
