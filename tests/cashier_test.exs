ExUnit.start()

defmodule CashierTest do
  use ExUnit.Case
  alias Supermarket.Products
  alias Supermarket.Cashier

  test "-Get product-" do
    assert Products.get_product("GR1") == %{name: "Green tea", price: 3.11, id: 1}
  end

  test "-Get product 2-" do
    assert Products.get_product("CF1") == %{name: "Coffee", price: 11.23, id: 3}
  end

  # test "-Simple scan-" do
  #   assert Cashier.scan(["GR1", "SR1", "GR1", "GR1", "CF1"]) == 25.56
  # end

  test "-Scan1-" do
    assert Cashier.do_scan(["GR1", "SR1", "GR1", "GR1", "CF1"]) == 22.45
  end

  test "-Scan2-" do
    assert Cashier.do_scan(["GR1", "GR1"]) == 3.11
  end

  test "-Scan3-" do
    assert Cashier.do_scan(["SR1", "SR1", "GR1", "SR1"]) == 16.61
  end

  test "-Scan4-" do
    assert Cashier.do_scan(["GR1", "CF1", "SR1", "CF1", "CF1"]) == 30.57
  end

  test "-Bad customer scan-" do
    assert Cashier.do_scan(["GR1", "CF1", "SR1", "CF1", "CF1"], false) == 41.80
  end
end
