require "spec_helper"

RSpec.describe Promrule do
  it "has a version number" do
    expect(Promrule::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end

__END__
group do
  record "instance:errors:rate5m" do
    expr "rate(errors_total[5m])"
  end

  record "instance:requests:rate5m" do
    expr "rate(request_total[5m])"
  end

  alert "HighErrors" do
    expr(
      <<-"EOE"
        sum without(instance) (instance:errors:rate5m)
        /
        sum without(instance) (instance:requests:rate5m)
      EOE
    )

    for "5m"

    labels do
      severity "critical"
    end

    annotations do
      description: "stuff's happening with {{ $labels.service }}"
    end
  end
end
